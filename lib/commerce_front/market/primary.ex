defmodule CommerceFront.Market.Primary do
  import Ecto.Query
  alias Ecto.Multi
  alias CommerceFront.{Settings, Repo}

  alias CommerceFront.Settings.{
    Asset,
    AssetTranche,
    Order,
    Trade,
    WalletTransaction,
    Ewallet,
    StakeHolding
  }

  require Decimal

  def quote_buy(asset_id, desired_qty) do
    asset_tranches =
      from(t in AssetTranche,
        where: t.asset_id == ^asset_id and t.state == ^"open" and t.qty_sold < t.quantity,
        order_by: [asc: t.seq]
      )
      |> Repo.all()

    {lines, filled} =
      Enum.reduce_while(asset_tranches, {[], Decimal.new("0")}, fn t, {acc, filled} ->
        remaining = Decimal.sub(t.quantity, t.qty_sold)
        need = Decimal.sub(desired_qty, filled)

        cond do
          Decimal.compare(need, 0) != :gt ->
            {:halt, {acc, filled}}

          Decimal.compare(remaining, need) != :lt ->
            line = %{asset_tranche_id: t.id, qty: need, unit_price: t.unit_price, seq: t.seq}
            {:halt, {[line | acc], Decimal.add(filled, need)}}

          true ->
            line = %{asset_tranche_id: t.id, qty: remaining, unit_price: t.unit_price, seq: t.seq}
            {:cont, {[line | acc], Decimal.add(filled, remaining)}}
        end
      end)

    lines = Enum.reverse(lines) |> IO.inspect(label: "lines")

    total_cost =
      Enum.reduce(lines, Decimal.new("0"), fn %{qty: q, unit_price: p}, acc ->
        Decimal.add(acc, Decimal.mult(q, p))
      end)

    %{
      lines: lines,
      filled_qty: filled,
      total_cost: total_cost
    }
  end

  def execute_primary_buy(user_id, asset_id, desired_qty, idempotency_key) do
    multi =
      Multi.new()
      |> Multi.run(:idempotency_check, fn repo, _changes ->
        existing =
          from(o in Order,
            where:
              o.user_id == ^user_id and o.idempotency_key == ^idempotency_key and
                o.source == ^"primary" and o.side == ^"buy",
            limit: 1
          )
          |> repo.one()

        if existing do
          {:error, {:duplicate_order, existing.id}}
        else
          {:ok, :ok}
        end
      end)
      |> Multi.run(:quote, fn _repo, _changes ->
        q = quote_buy(asset_id, desired_qty)
        if Decimal.compare(q.filled_qty, 0) != :gt, do: {:error, :no_liquidity}, else: {:ok, q}
      end)
      |> Multi.run(:lock_balance, fn repo, _changes ->
        bal =
          from(e in Ewallet,
            where: e.user_id == ^user_id and e.wallet_type == ^"token"
          )
          |> repo.one()

        if is_nil(bal), do: {:error, :balance_not_found}, else: {:ok, bal}
      end)
      |> Multi.run(:check_funds, fn _repo, %{lock_balance: bal, quote: q} ->
        if Decimal.compare(Decimal.new("#{bal.total}"), q.total_cost) == :lt,
          do: {:error, :insufficient_funds},
          else: {:ok, :ok}
      end)
      |> Multi.run(:lock_tranches, fn repo, %{quote: q} ->
        asset_tranche_ids = Enum.map(q.lines, & &1.asset_tranche_id)

        tranches =
          from(t in AssetTranche,
            where: t.id in ^asset_tranche_ids,
            lock: "FOR UPDATE"
          )
          |> repo.all()
          |> Map.new(&{&1.id, &1})

        {:ok, tranches}
      end)
      |> Multi.run(:create_order, fn repo, _changes ->
        %Order{}
        |> Order.changeset(%{
          user_id: user_id,
          asset_id: asset_id,
          side: "buy",
          source: "primary",
          order_type: "market",
          qty: desired_qty,
          price: nil,
          idempotency_key: idempotency_key
        })
        |> repo.insert()
      end)
      |> Multi.run(:apply_fills, fn repo,
                                    %{quote: q, lock_tranches: tranches, create_order: order} ->
        Enum.reduce_while(q.lines, {:ok, {Decimal.new("0"), []}}, fn %{
                                                                       asset_tranche_id: tid,
                                                                       qty: qty
                                                                     },
                                                                     {:ok, {acc_cost, trade_ids}} ->
          t = tranches[tid]
          available = Decimal.sub(t.quantity, t.qty_sold)

          IO.inspect(available, label: "available")
          IO.inspect(qty, label: "qty")

          if Decimal.compare(available, qty) == :lt,
            do: {:halt, {:error, :race_condition}},
            else: :ok

          {count, _} =
            repo.update_all(
              from(x in AssetTranche, where: x.id == ^tid),
              set: [qty_sold: Decimal.to_float(t.qty_sold) +  Decimal.to_float(qty) ]
            )

          if count != 1, do: {:halt, {:error, :tranche_update_failed}}, else: :ok

          {:ok, trade} =
            repo.insert(%Trade{
              asset_id: asset_id,
              buyer_order_id: order.id,
              seller_order_id: nil,
              tranche_id: tid,
              side: "primary",
              price: t.unit_price,
              qty: qty,
              inserted_at: DateTime.utc_now()
            })
          IO.inspect(acc_cost, label: "acc_cost")
          IO.inspect(qty, label: "qty")
          IO.inspect(t.unit_price, label: "t.unit_price")
          new_cost = Decimal.add(acc_cost, Decimal.mult(qty, t.unit_price))
          {:cont, {:ok, {new_cost, [trade.id | trade_ids]}}}
        end)
      end)
      |> Multi.run(:debit_buyer, fn repo, %{lock_balance: bal, apply_fills: {total_cost, _}} ->
        Settings.create_wallet_transaction(%{
          user_id: user_id,
          amount: Decimal.to_float(total_cost) * -1,
          remarks: "primary_buy",
          wallet_type: "token"
        })
      end)
      |> Multi.run(:issuer_balance, fn repo, _changes ->
        asset = repo.get!(Asset, asset_id)
        finance_user = Settings.finance_user()

        bal =
          from(e in Ewallet, where: e.user_id == ^finance_user.id and e.wallet_type == ^"token")
          |> repo.one()

        {:ok, %{asset: asset, issuer_balance: bal}}
      end)
      |> Multi.run(:ensure_issuer_balance, fn repo,
                                              %{
                                                issuer_balance: %{
                                                  asset: asset,
                                                  issuer_balance: bal
                                                },
                                                apply_fills: {total_cost, _}
                                              } ->
        if is_nil(bal) do
          finance_user = Settings.finance_user()

          ibal =
            Settings.create_wallet_transaction(%{
              user_id: finance_user.id,
              amount: Decimal.to_float(total_cost),
              remarks: "primary_buy",
              wallet_type: "token"
            })

          {:ok, ibal}
        else
          {:ok, bal}
        end
      end)
      |> Multi.run(:credit_issuer, fn repo,
                                      %{ensure_issuer_balance: ibal, apply_fills: {total_cost, _}} ->
        {:ok, nil}
      end)
      |> Multi.run(:create_asset_wallet_transaction, fn repo, %{quote: q} ->
        # Create a wallet transaction for the asset purchase
        # This represents the user's asset holdings in their wallet
        wallet_params = %{
          user_id: user_id,
          amount: Decimal.to_float(q.filled_qty),
          remarks: "primary buy asset(id:#{asset_id})",
          wallet_type: "asset"  # Using asset wallet for asset holdings
        }

        case Settings.create_wallet_transaction(wallet_params) do
          {:ok, result} -> {:ok, result}
          {:error, changeset} -> {:error, changeset}
        end
      end)
      |> Multi.run(:create_stake_holding, fn repo, %{quote: q, create_asset_wallet_transaction: wallet_result} ->
        # Create a stake holding entry for the newly purchased quantity
        # This will be staked at 1% per day
        # We'll use the wallet_transaction ID as a reference
        stake_params = %{
          holding_id: wallet_result.wallet_transaction.id,  # Reference to wallet transaction
          original_qty: q.filled_qty,
          initial_bought: Date.utc_today(),
          released: Decimal.new("0")
        }

        case repo.insert(StakeHolding.changeset(%StakeHolding{}, stake_params)) do
          {:ok, stake_holding} -> {:ok, stake_holding}
          {:error, changeset} -> {:error, changeset}
        end
      end)
      |> Multi.run(:finalize_order, fn repo, %{create_order: order, quote: q} ->
        status =
          if Decimal.compare(q.filled_qty, desired_qty) == :eq,
            do: "filled",
            else: "partially_filled"

        {count, _} =
          repo.update_all(from(o in Order, where: o.id == ^order.id),
            set: [status: status, qty_filled: q.filled_qty]
          )

        if count != 1,
          do: {:error, :finalize_failed},
          else:
            {:ok,
             %{
               order_id: order.id,
               filled_qty: q.filled_qty,
               total_cost: q.total_cost,
               status: status
             }}
      end)

    case Repo.transaction(multi) do
      {:ok, %{finalize_order: res}} -> {:ok, res |> BluePotion.sanitize_struct()}
      {:error, _step, reason, _changes} -> {:error, reason}
    end
  end
end
