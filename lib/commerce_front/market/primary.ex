defmodule CommerceFront.Market.Primary do
    import Ecto.Query
    alias Ecto.Multi
    alias CommerceFront.Repo
    alias CommerceFront.Settings.{Asset, AssetTranche, Order, Trade, Holding, Balance, LedgerEntry}

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
              line = %{asset_tranche_id: t.id, qty: need, unit_price: t.unit_price}
              {:halt, {[line | acc], Decimal.add(filled, need)}}
  
            true ->
              line = %{asset_tranche_id: t.id, qty: remaining, unit_price: t.unit_price}
              {:cont, {[line | acc], Decimal.add(filled, remaining)}}
          end
        end)
  
      lines = Enum.reverse(lines)
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
            from(b in Balance,
              where: b.user_id == ^user_id and b.currency == ^"USD",
              lock: "FOR UPDATE"
            )
            |> repo.one()

          if is_nil(bal), do: {:error, :balance_not_found}, else: {:ok, bal}
        end)
        |> Multi.run(:check_funds, fn _repo, %{lock_balance: bal, quote: q} ->
          if Decimal.compare(bal.available, q.total_cost) == :lt, do: {:error, :insufficient_funds}, else: {:ok, :ok}
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
            side: :buy,
            source: :primary,
            order_type: :market,
            qty: desired_qty,
            price: nil,
            idempotency_key: idempotency_key
          })
          |> repo.insert()
        end)
        |> Multi.run(:apply_fills, fn repo, %{quote: q, lock_tranches: tranches, create_order: order} ->
          Enum.reduce_while(q.lines, {:ok, {Decimal.new("0"), []}}, fn %{asset_tranche_id: tid, qty: qty}, {:ok, {acc_cost, trade_ids}} ->
            t = tranches[tid]
            available = Decimal.sub(t.quantity, t.qty_sold)
            if Decimal.compare(available, qty) == :lt, do: {:halt, {:error, :race_condition}}, else: :ok

            {count, _} =
              repo.update_all(
                from(x in AssetTranche, where: x.id == ^tid),
                set: [qty_sold: Decimal.add(t.qty_sold, qty)]
              )

            if count != 1, do: {:halt, {:error, :tranche_update_failed}}, else: :ok

            {:ok, trade} =
              repo.insert(%Trade{
                asset_id: asset_id,
                buyer_order_id: order.id,
                seller_order_id: nil,
                tranche_id: tid,
                side: :primary,
                price: t.unit_price,
                qty: qty
              })

            new_cost = Decimal.add(acc_cost, Decimal.mult(qty, t.unit_price))
            {:cont, {:ok, {new_cost, [trade.id | trade_ids]}}}
          end)
        end)
        |> Multi.run(:debit_buyer, fn repo, %{lock_balance: bal, apply_fills: {total_cost, _}} ->
          {count, _} =
            repo.update_all(
              from(b in Balance, where: b.id == ^bal.id),
              set: [available: Decimal.sub(bal.available, total_cost)]
            )
          if count != 1, do: {:error, :debit_failed}, else: {:ok, :ok}
        end)
        |> Multi.run(:issuer_balance, fn repo, _changes ->
          asset = repo.get!(Asset, asset_id)
          bal =
            from(b in Balance, where: b.user_id == ^asset.owner_id and b.currency == ^"USD", lock: "FOR UPDATE")
            |> repo.one()
          {:ok, %{asset: asset, issuer_balance: bal}}
        end)
        |> Multi.run(:ensure_issuer_balance, fn repo, %{issuer_balance: %{asset: asset, issuer_balance: bal}} ->
          if is_nil(bal) do
            repo.insert(%Balance{user_id: asset.owner_id, currency: "USD"})
          else
            {:ok, bal}
          end
        end)
        |> Multi.run(:credit_issuer, fn repo, %{ensure_issuer_balance: ibal, apply_fills: {total_cost, _}} ->
          {count, _} =
            repo.update_all(
              from(b in Balance, where: b.id == ^ibal.id),
              set: [available: Decimal.add(ibal.available, total_cost)]
            )
          if count != 1, do: {:error, :credit_failed}, else: {:ok, :ok}
        end)
        |> Multi.run(:update_holding, fn repo, %{quote: q} ->
          holding =
            from(h in Holding, where: h.user_id == ^user_id and h.asset_id == ^asset_id, lock: "FOR UPDATE")
            |> repo.one()
          holding = holding || (%Holding{user_id: user_id, asset_id: asset_id} |> repo.insert!())

          new_qty = Decimal.add(holding.quantity, q.filled_qty)
          new_avg =
            if Decimal.compare(new_qty, 0) == :eq do
              Decimal.new("0")
            else
              total_paid = Decimal.add(Decimal.mult(holding.quantity, holding.average_price), q.total_cost)
              Decimal.div(total_paid, new_qty)
            end

          {count, _} =
            repo.update_all(
              from(h in Holding, where: h.id == ^holding.id),
              set: [quantity: new_qty, average_price: new_avg]
            )
          if count != 1, do: {:error, :holding_update_failed}, else: {:ok, %{new_qty: new_qty, new_avg: new_avg}}
        end)
        |> Multi.run(:ledger_entries, fn repo, %{create_order: order, apply_fills: {total_cost, trade_ids}, quote: q} ->
          trade_ids = Enum.reverse(trade_ids)
          reference = %{type: "primary_buy", order_id: order.id, asset_id: asset_id, trade_ids: trade_ids}

          asset = repo.get!(Asset, asset_id)

          with {:ok, _} <- repo.insert(%LedgerEntry{user_id: user_id, asset_id: asset_id, journal: "cash", currency: "USD", amount: total_cost, direction: "debit", reference: reference}),
               {:ok, _} <- repo.insert(%LedgerEntry{user_id: asset.owner_id, asset_id: asset_id, journal: "cash", currency: "USD", amount: total_cost, direction: "credit", reference: reference}),
               {:ok, _} <- repo.insert(%LedgerEntry{user_id: user_id, asset_id: asset_id, journal: "asset", currency: "UNIT", amount: q.filled_qty, direction: "credit", reference: reference}) do
            {:ok, :ok}
          else
            {:error, reason} -> {:error, reason}
          end
        end)
        |> Multi.run(:finalize_order, fn repo, %{create_order: order, quote: q} ->
          status = if Decimal.compare(q.filled_qty, desired_qty) == :eq, do: :filled, else: :partially_filled
          {count, _} = repo.update_all(from(o in Order, where: o.id == ^order.id), set: [status: status, qty_filled: q.filled_qty])
          if count != 1, do: {:error, :finalize_failed}, else: {:ok, %{order_id: order.id, filled_qty: q.filled_qty, total_cost: q.total_cost, status: status}}
        end)

      case Repo.transaction(multi) do
        {:ok, %{finalize_order: res}} -> {:ok, res}
        {:error, _step, reason, _changes} -> {:error, reason}
      end
    end
  end