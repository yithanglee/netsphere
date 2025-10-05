defmodule CommerceFront.Market.Secondary do
  @moduledoc """
  Secondary market for trading active_token assets between users.
  Now integrated with asset tranches - members must buy at current tranche price.
  """

  import Ecto.Query
  alias Ecto.Multi
  alias CommerceFront.{Repo, Settings}

  alias CommerceFront.Settings.{
    SecondaryMarketOrder,
    SecondaryMarketTrade,
    AssetTranche,
    StakeHolding, Ewallet
  }

  require Decimal
  require IEx

  # ============================================================================
  # TRANCHE HELPER FUNCTIONS
  # ============================================================================

  @doc """
  Get the current open tranche for an asset.
  Returns the tranche with the lowest sequence number that still has available quantity.
  """
  def get_current_open_tranche(asset_id) do
    from(t in AssetTranche,
      where:
        t.asset_id == ^asset_id and
          t.state == ^"open" and
          t.traded_qty < t.quantity,
      order_by: [asc: t.seq],
      limit: 1
    )
    |> Repo.one()
  end

  @doc """
  Update the sold quantity for a tranche.
  """
  def update_tranche_sold_quantity(tranche_id, additional_qty) do
    from(t in AssetTranche, where: t.id == ^tranche_id)
    |> Repo.update_all(inc: [qty_sold: Decimal.to_float(additional_qty)])
  end

  def update_tranche_traded_quantity(tranche_id, additional_qty) do
    from(t in AssetTranche, where: t.id == ^tranche_id)
    |> Repo.update_all(inc: [traded_qty: Decimal.to_float(additional_qty)])
  end

  @doc """
  Check if a tranche is fully sold after an update.
  """
  def is_tranche_fully_sold?(tranche_id) do

    case Repo.get(AssetTranche, tranche_id) do
      nil -> false
      tranche -> Decimal.compare(tranche.traded_qty, tranche.quantity) >= 0
    end
  end
#todo check the compare 2 types
  defp close_tranche_if_filled(%AssetTranche{} = tranche) do

    if Decimal.compare(tranche.traded_qty, tranche.quantity) != :lt do
      # Close current tranche
      from(t in AssetTranche, where: t.id == ^tranche.id)
      |> Repo.update_all(set: [state: "closed"])
      |> elem(1)

      # Open next tranche by sequence if exists
      next =
        from(t in AssetTranche,
          where: t.asset_id == ^tranche.asset_id and t.seq > ^tranche.seq,
          order_by: [asc: t.seq],
          limit: 1
        )
        |> Repo.one()

      if next do
        from(t in AssetTranche, where: t.id == ^next.id)
        |> Repo.update_all(set: [state: "open", released_at: DateTime.utc_now()])
      end

      :closed
    else
      :open
    end
  end

  @doc """
  Inject a synthetic sell order to fulfill buy orders when no member sells exist.
  This increases the tranche's sold quantity.
  """
  def inject_synthetic_sell_order(asset_id, quantity, price_per_unit, buyer_id) do
    # Create a synthetic sell order with a system user ID (finance user)
    finance_user = Settings.finance_user()

    order_params = %{
      user_id: finance_user.id,
      order_type: "sell",
      asset_id: asset_id,
      quantity: quantity,
      price_per_unit: price_per_unit,
      total_amount: Decimal.mult(quantity, price_per_unit),
      # Immediately filled
      status: "filled",
      filled_quantity: quantity,
      remaining_quantity: Decimal.new("0")
    }

    case Settings.create_secondary_market_order(order_params) do
      {:ok, synthetic_order} ->
        # Create the trade immediately
        trade_params = %{
          # Will be set by caller
          buy_order_id: nil,
          sell_order_id: synthetic_order.id,
          buyer_id: buyer_id,
          seller_id: finance_user.id,
          asset_id: asset_id,
          quantity: quantity,
          price_per_unit: price_per_unit,
          total_amount: Decimal.mult(quantity, price_per_unit),
          trade_date: DateTime.utc_now()
        }

        {:ok, {synthetic_order, trade_params}}

      error ->
        error
    end
  end

  # ============================================================================
  # ORDER CREATION FUNCTIONS
  # ============================================================================

  @doc """
  Create a sell order for active_token assets.
  """
  def create_sell_order(user_id, asset_id, quantity, price_per_unit) do
    # Enforce only one active (pending) sell order per user per asset
    existing_active_sell_count =
      from(o in SecondaryMarketOrder,
        where:
          o.user_id == ^user_id and
            o.asset_id == ^asset_id and
            o.order_type == "sell" and
            o.status == "pending",
        select: count(o.id)
      )
      |> Repo.one()

    if existing_active_sell_count > 0 do
      {:error, "You already have an active sell order for this asset"}
    else
      total_amount = Decimal.mult(quantity, price_per_unit)

      # Check if user has sufficient active_token balance
      unless Settings.has_sufficient_active_token_balance?(user_id, asset_id, quantity) do
        {:error, "Insufficient active_token balance"}
      else
        order_params = %{
          user_id: user_id,
          order_type: "sell",
          asset_id: asset_id,
          quantity: quantity,
          price_per_unit: price_per_unit,
          total_amount: total_amount,
          status: "pending",
          filled_quantity: Decimal.new("0"),
          remaining_quantity: quantity
        }

        with {:ok, order} <- Settings.create_secondary_market_order(order_params) do
          # Try to match with existing buy orders
          match_and_execute_trades(order)
          {:ok, order}
        end
      end
    end
  end

  @doc """
  Create a buy order for active_token assets.
  Now enforces tranche pricing - buy orders must be at current tranche price.
  CommerceFront.Market.Secondary.create_buy_order(37, 1, 35000, 0.001)

  """
  def create_buy_order(user_id, asset_id, quantity, price_per_unit) do
    # First, get the current open tranche to enforce pricing
    case get_current_open_tranche(asset_id) do
      nil ->
        {:error, "No open tranche available for this asset"}

      current_tranche ->
        # Enforce tranche pricing - buy orders must match current tranche price
        if Decimal.compare(price_per_unit, current_tranche.unit_price) != :eq do
          {:error, "Buy orders must be at current tranche price: #{current_tranche.unit_price}"}
        else
          total_amount = Decimal.mult(quantity, price_per_unit)

          # Check if user has sufficient token balance
          unless Settings.has_sufficient_token_balance?(user_id, total_amount) do
            {:error, "Insufficient token balance"}
          else
            order_params = %{
              user_id: user_id,
              order_type: "buy",
              asset_id: asset_id,
              quantity: quantity,
              price_per_unit: price_per_unit,
              total_amount: total_amount,
              status: "pending",
              filled_quantity: Decimal.new("0"),
              remaining_quantity: quantity
            }

            with {:ok, order} <- Settings.create_secondary_market_order(order_params) |> IO.inspect(label: "market order") do
              # Try to match with existing sell orders or inject liquidity
              match_and_execute_tranche_based_trades(order, current_tranche)
              {:ok, order}
            end
          end
        end
    end
  end

  @doc """
  Match a new order with existing orders and execute trades (legacy function).
  """
  def match_and_execute_trades(new_order) do
    case new_order.order_type do
      "buy" -> match_buy_order_with_sells(new_order)
      "sell" -> match_sell_order_with_buys(new_order)
    end
  end

  @doc """
  Match and execute trades using tranche-based rules.
  For buy orders: first try to match with member sells at tranche price, then inject if needed.
  """
  def match_and_execute_tranche_based_trades(buy_order, current_tranche) do
    # Only handle buy orders with this new logic
    case buy_order.order_type do
      "buy" ->
        match_buy_order_with_tranche_rules(buy_order, current_tranche)

      "sell" ->
        # Sell orders use existing logic for now
        match_sell_order_with_buys(buy_order)
    end
  end

  # Match buy order using tranche-based rules:
  # 1. Find member sell orders at exactly the current tranche price
  # 2. If insufficient, inject synthetic sell orders from tranche
  # 3. Update tranche sold quantity
  # 4. Move to next tranche if current is exhausted
  defp match_buy_order_with_tranche_rules(buy_order, current_tranche) do
    tranche_price = current_tranche.unit_price
    remaining_to_fill = buy_order.remaining_quantity

    # Step 1: Find member sell orders at exactly the tranche price
    member_sell_orders =
      from(o in SecondaryMarketOrder,
        where:
          o.asset_id == ^buy_order.asset_id and
            o.order_type == "sell" and
            o.status == "pending" and
            o.price_per_unit == ^tranche_price and
            o.user_id != ^buy_order.user_id,
        # FIFO for same price
        order_by: [asc: o.inserted_at]
      )
      |> Repo.all()

    # Step 2: Execute trades with member orders first
    remaining_after_member_trades =
      execute_member_trades(buy_order, member_sell_orders, remaining_to_fill) |> IO.inspect(label: "remaining_after_member_trades")

    # Record traded quantity attributed to this tranche from member fills
    member_filled_quantity = Decimal.sub(remaining_to_fill, remaining_after_member_trades) |> IO.inspect(label: "member_filled_quantity")

    if Decimal.compare(member_filled_quantity, Decimal.new("0")) == :gt do
      update_tranche_traded_quantity(current_tranche.id, member_filled_quantity) |> IO.inspect(label: "update_tranche_traded_quantity")
    end

    # Step 3: If still need to fill, inject from tranche
    tranche_res =
    if Decimal.compare(remaining_after_member_trades, Decimal.new("0")) == :gt do
      inject_from_tranche(buy_order, current_tranche, remaining_after_member_trades) |> IO.inspect(label: "remaining_after_inject_from_tranche")
    end

    # Step 4: Update order status
    updated_buy_order = Repo.get!(SecondaryMarketOrder, buy_order.id)

    if Decimal.compare(updated_buy_order.remaining_quantity, Decimal.new("0")) == :eq do
      update_order_status(buy_order, "filled")
    end

    # Step 5: If tranche filled, close and open next
    tranche = Repo.get!(AssetTranche, current_tranche.id)
    close_tranche_if_filled(tranche)
  end

  defp execute_member_trades(buy_order, sell_orders, remaining_quantity) do
    Enum.reduce_while(sell_orders, remaining_quantity, fn sell_order, remaining ->
      if Decimal.compare(remaining, Decimal.new("0")) == :eq do
        {:halt, remaining}
      else
        trade_quantity = Decimal.min(remaining, sell_order.remaining_quantity)
        trade_price = sell_order.price_per_unit
        trade_amount = Decimal.mult(trade_quantity, trade_price)

        # Create the trade
        trade_params = %{
          buy_order_id: buy_order.id,
          sell_order_id: sell_order.id,
          buyer_id: buy_order.user_id,
          seller_id: sell_order.user_id,
          asset_id: buy_order.asset_id,
          quantity: trade_quantity,
          price_per_unit: trade_price,
          total_amount: trade_amount,
          trade_date: DateTime.utc_now()
        }

        case execute_trade(trade_params, buy_order, sell_order) do
          {:ok, _} ->
            new_remaining = Decimal.sub(remaining, trade_quantity)
            {:cont, new_remaining}

          {:error, _} ->
            {:halt, remaining}
        end
      end
    end)
  end

  @doc """
  Inject synthetic sell orders from tranche to fulfill buy orders.
  """
  def inject_from_tranche(buy_order, current_tranche, needed_quantity) do
    # Refresh tranche to avoid stale qty_sold/traded_qty
    tranche = Repo.get!(AssetTranche, current_tranche.id)

    # Caps: total remaining and company remaining
    available_total = Decimal.sub(tranche.quantity, tranche.traded_qty)
    available_company = Decimal.sub(tranche.quantity, tranche.qty_sold)

    # Determine how much we can inject from current tranche (respect both caps)
    injection_quantity =
      needed_quantity
      |> Decimal.min(available_company)

    if Decimal.compare(injection_quantity, Decimal.new("0")) == :gt do
      # Inject synthetic sell order
      case inject_synthetic_sell_order(
             buy_order.asset_id,
             injection_quantity,
             tranche.unit_price,
             buy_order.user_id
      )  do
        {:ok, {synthetic_order, trade_params}} ->
          # Update trade params with buy order ID
          trade_params = Map.put(trade_params, :buy_order_id, buy_order.id)

          # Execute the trade
          case execute_synthetic_trade(trade_params, buy_order, tranche) do
            {:ok, _} ->
              # Update tranche sold quantity
              update_tranche_sold_quantity(tranche.id, injection_quantity)
              # Update total traded quantity (includes company injection)
              update_tranche_traded_quantity(tranche.id, injection_quantity)

              # Check if we need to move to next tranche for remaining quantity
              remaining_after_injection = Decimal.sub(needed_quantity, injection_quantity)

              if Decimal.compare(remaining_after_injection, Decimal.new("0")) == :gt do
                # Try next tranche if current is exhausted

                if is_tranche_fully_sold?(tranche.id) do
                  case get_current_open_tranche(buy_order.asset_id) do
                    nil ->
                      :no_more_tranches

                    next_tranche ->
                      inject_from_tranche(buy_order, next_tranche, remaining_after_injection)
                  end
                end
              end


              # After injection, check if tranche is filled and rotate
              tranche = Repo.get!(AssetTranche, tranche.id)
              close_tranche_if_filled(tranche)

            {:error, reason} ->
              {:error, "Failed to execute synthetic trade: #{inspect(reason)}"}
          end

        {:error, reason} ->
          {:error, "Failed to inject synthetic order: #{inspect(reason)}"}
      end
    end
  end

  defp execute_synthetic_trade(trade_params, buy_order, tranche) do
    with {:ok, wallet_tx_refs} <- execute_wallet_transfers(trade_params),
         {:ok, _trade} <-
                Settings.create_secondary_market_trade(
                  Map.merge(trade_params, wallet_tx_refs)
                ) do
      # Update buy order quantities
      update_order_filled_quantity(buy_order, trade_params.quantity)

      {:ok, :success}
    else
      error -> {:error, "Synthetic trade execution failed: #{inspect(error)}"}
    end
  end

  defp match_buy_order_with_sells(buy_order) do
    # Get sell orders with price <= buy order price, sorted by lowest price first
    sell_orders =
      from(o in SecondaryMarketOrder,
        where:
          o.asset_id == ^buy_order.asset_id and
            o.order_type == "sell" and
            o.status == "pending" and
            o.price_per_unit <= ^buy_order.price_per_unit and
            o.user_id != ^buy_order.user_id,
        order_by: [asc: o.price_per_unit, asc: o.inserted_at]
      )
      |> Repo.all()

    execute_trades(buy_order, sell_orders)
  end

  defp match_sell_order_with_buys(sell_order) do
    # Get buy orders with price >= sell order price, sorted by highest price first
    buy_orders =
      from(o in SecondaryMarketOrder,
        where:
          o.asset_id == ^sell_order.asset_id and
            o.order_type == "buy" and
            o.status == "pending" and
            o.price_per_unit >= ^sell_order.price_per_unit and
            o.user_id != ^sell_order.user_id,
        order_by: [desc: o.price_per_unit, desc: o.inserted_at]
      )
      |> Repo.all()

    execute_trades(sell_order, buy_orders)
  end

  defp execute_trades(main_order, matching_orders) do
    remaining_quantity = main_order.remaining_quantity

    if Decimal.compare(remaining_quantity, Decimal.new("0")) == :eq do
      # Order is already filled
      update_order_status(main_order, "filled")
      :ok
    else
      Enum.reduce_while(matching_orders, remaining_quantity, fn matching_order, remaining ->
        if Decimal.compare(remaining, Decimal.new("0")) == :eq do
          {:halt, remaining}
        else
          trade_quantity = Decimal.min(remaining, matching_order.remaining_quantity)
          # Use the matching order's price (better for the new order)
          trade_price = matching_order.price_per_unit
          trade_amount = Decimal.mult(trade_quantity, trade_price)

          # Create the trade
          trade_params = %{
            buy_order_id:
              if(main_order.order_type == "buy", do: main_order.id, else: matching_order.id),
            sell_order_id:
              if(main_order.order_type == "sell", do: main_order.id, else: matching_order.id),
            buyer_id:
              if(main_order.order_type == "buy",
                do: main_order.user_id,
                else: matching_order.user_id
              ),
            seller_id:
              if(main_order.order_type == "sell",
                do: main_order.user_id,
                else: matching_order.user_id
              ),
            asset_id: main_order.asset_id,
            quantity: trade_quantity,
            price_per_unit: trade_price,
            total_amount: trade_amount,
            trade_date: DateTime.utc_now()
          }

          case execute_trade(trade_params, main_order, matching_order) do
            {:ok, _} ->
              new_remaining = Decimal.sub(remaining, trade_quantity)
              {:cont, new_remaining}

            {:error, _} ->
              {:halt, remaining}
          end
        end
      end)

      # Check if main order is now filled
      updated_main_order = Repo.get!(SecondaryMarketOrder, main_order.id)

      if Decimal.compare(updated_main_order.remaining_quantity, Decimal.new("0")) == :eq do
        update_order_status(main_order, "filled")
      end
    end
  end

  defp execute_trade(trade_params, main_order, matching_order) do
    with {:ok, wallet_tx_refs} <- execute_wallet_transfers(trade_params),
         {:ok, _trade} <-
                Settings.create_secondary_market_trade(
                  Map.merge(trade_params, wallet_tx_refs)
                ) do
      # Update order quantities
      update_order_filled_quantity(main_order, trade_params.quantity)
      update_order_filled_quantity(matching_order, trade_params.quantity)

      # Check if matching order is now filled
      if Decimal.compare(matching_order.remaining_quantity, trade_params.quantity) == :eq do
        update_order_status(matching_order, "filled")
      end

      {:ok, :success}
    else
      error -> {:error, "Trade execution failed: #{inspect(error)}"}
    end
  end

  defp execute_wallet_transfers(trade_params) do
    finance_user = Settings.finance_user()
    is_synthetic_seller = trade_params.seller_id == finance_user.id

    # Precompute wallet transaction param maps
    buyer_token_debit = %{
      user_id: trade_params.buyer_id,
      amount: -Decimal.to_float(trade_params.total_amount),
      remarks: "secondary_market_buy_#{trade_params.asset_id}_#{trade_params.trade_date} | qty: #{trade_params.quantity}",
      wallet_type: "token"
    }

    buyer_asset_credit = %{
      user_id: trade_params.buyer_id,
      amount: Decimal.to_float(trade_params.quantity),
      remarks:
        "secondary_market_receive_asset_#{trade_params.asset_id}_#{trade_params.trade_date}",
      wallet_type: "asset"
    }

    seller_token_credit = %{
      user_id: trade_params.seller_id,
      amount: (Decimal.to_float(trade_params.total_amount) * 0.3) |> Float.round(2),
      remarks:
        "secondary_market_receive_tokens_#{trade_params.asset_id}_#{trade_params.trade_date}| qty: #{trade_params.quantity}| total_amount: #{trade_params.total_amount}",
      wallet_type: "token"
    }

    seller_bonus_credit = %{
      user_id: trade_params.seller_id,
      amount: (Decimal.to_float(trade_params.total_amount) * 0.7) |> Float.round(2),
      remarks:
        "secondary_market_receive_tokens_#{trade_params.asset_id}_#{trade_params.trade_date}| qty: #{trade_params.quantity}| total_amount: #{trade_params.total_amount}",
      wallet_type: "bonus"
    }

    seller_active_token_debit = %{
      user_id: trade_params.seller_id,
      amount: -Decimal.to_float(trade_params.quantity),
      remarks:
        "secondary_market_sell_active_token_#{trade_params.asset_id}_#{trade_params.trade_date}| qty: #{trade_params.quantity}| total_amount: #{trade_params.total_amount}",
      wallet_type: "active_token"
    }

    seller_asset_debit = %{
      user_id: trade_params.seller_id,
      amount: -Decimal.to_float(trade_params.quantity),
      remarks:
        "secondary_market_deduct_asset_#{trade_params.asset_id}_#{trade_params.trade_date}| qty: #{trade_params.quantity}| total_amount: #{trade_params.total_amount}",
      wallet_type: "asset"
    }

    multi =
      Multi.new()
      |> Multi.run(:lock_buyer_token_wallet, fn repo, _changes ->
        bal =
          from(e in Ewallet,
            where: e.user_id == ^trade_params.buyer_id and e.wallet_type == ^"token",
            lock: "FOR UPDATE"
          )
          |> repo.one()

        cond do
          is_nil(bal) -> {:error, :buyer_wallet_not_found}
          Decimal.compare(Decimal.from_float(bal.total), trade_params.total_amount) == :lt ->
            {:error, :insufficient_funds}
          true -> {:ok, bal}
        end
      end)
      |> Multi.run(:buyer_token_debit, fn _repo, _ ->
        Settings.create_wallet_transaction(buyer_token_debit)
      end)
      |> Multi.run(:buyer_asset_credit, fn _repo, _ ->
        Settings.create_wallet_transaction(buyer_asset_credit)
      end)
      |> Multi.run(:create_stake_holding, fn repo, %{buyer_asset_credit: buyer_asset_tx} ->
        # Create stake holding linked to the wallet transaction that credited assets
        # Mirroring primary flow: stake at 1% per day based on credited quantity
        qty =
          (buyer_asset_tx.wallet_transaction && buyer_asset_tx.wallet_transaction.amount) ||
            Decimal.to_float(trade_params.quantity)

        params = %{
          holding_id: buyer_asset_tx.wallet_transaction.id,
          original_qty: Decimal.new("#{qty}"),
          initial_bought: Date.utc_today(),
          released: Decimal.new("0")
        }

        case repo.insert(StakeHolding.changeset(%StakeHolding{}, params)) do
          {:ok, stake} -> {:ok, stake}
          {:error, cs} -> {:error, cs}
        end
      end)
      |> then(fn m ->
        if is_synthetic_seller do
          # Issuer synthetic sell: only credit issuer tokens
          m
          |> Multi.run(:seller_token_credit, fn _repo, _ ->
            Settings.create_wallet_transaction(seller_token_credit)
          end)
        else
          # Member-to-member: deduct seller active_token and asset, then credit tokens
          m
          |> Multi.run(:seller_active_token_debit, fn _repo, _ ->
            Settings.create_wallet_transaction(seller_active_token_debit)
          end)
          |> Multi.run(:seller_asset_debit, fn _repo, _ ->
            Settings.create_wallet_transaction(seller_asset_debit)
          end)
          |> Multi.run(:seller_token_credit, fn _repo, _ ->
            Settings.create_wallet_transaction(seller_token_credit)
          end)
          |> Multi.run(:seller_bonus_credit, fn _repo, _ ->
            Settings.create_wallet_transaction(seller_bonus_credit)
          end)
          |> Multi.run(:secondary_market_buy, fn _repo,
                                                 %{seller_token_credit: seller_token_credit} ->
            current_tranche = CommerceFront.Market.Secondary.get_current_open_tranche(1)

            wt =
              seller_token_credit
              |> Map.get(:wallet_transaction)
              |> IO.inspect(label: "wallet transaction")

            CommerceFront.Market.Secondary.create_buy_order(
              wt.user_id,
              current_tranche.asset_id,
              Decimal.from_float(wt.amount / (current_tranche.unit_price |> Decimal.to_float())),
              current_tranche.unit_price
            )

            {:ok, nil}
          end)
        end
      end)

    case Repo.transaction(multi) do
      {:ok, results} ->
        # Build wallet transaction id references from results
        refs = %{}
        refs =
          case Map.get(results, :buyer_token_debit) do
            %{wallet_transaction: wt} -> Map.put(refs, :buyer_token_tx_id, wt.id)
            _ -> refs
          end
        refs =
          case Map.get(results, :buyer_asset_credit) do
            %{wallet_transaction: wt} -> Map.put(refs, :buyer_asset_tx_id, wt.id)
            _ -> refs
          end
        refs =
          case Map.get(results, :seller_token_credit) do
            %{wallet_transaction: wt} -> Map.put(refs, :seller_token_tx_id, wt.id)
            _ -> refs
          end
        refs =
          case Map.get(results, :seller_bonus_credit) do
            %{wallet_transaction: wt} -> Map.put(refs, :seller_bonus_tx_id, wt.id)
            _ -> refs
          end
        refs =
          case Map.get(results, :seller_active_token_debit) do
            %{wallet_transaction: wt} -> Map.put(refs, :seller_active_token_tx_id, wt.id)
            _ -> refs
          end
        refs =
          case Map.get(results, :seller_asset_debit) do
            %{wallet_transaction: wt} -> Map.put(refs, :seller_asset_tx_id, wt.id)
            _ -> refs
          end

        {:ok, refs}

      {:error, _step, reason, _changes} ->
        {:error, "Wallet transfer failed: #{inspect(reason)}"}
    end
  end

  defp update_order_filled_quantity(order, fill_quantity) do
    new_filled = Decimal.add(order.filled_quantity, fill_quantity)
    new_remaining = Decimal.sub(order.remaining_quantity, fill_quantity)

    Settings.update_secondary_market_order(order, %{
      filled_quantity: new_filled,
      remaining_quantity: new_remaining
    })
  end

  defp update_order_status(order, status) do
    Settings.update_secondary_market_order(order, %{status: status})
  end

  @doc """
  Cancel an order.
  """
  def cancel_order(order_id, user_id) do
    case Repo.get(SecondaryMarketOrder, order_id) do
      nil ->
        {:error, "Order not found"}

      order ->
        if order.user_id != user_id do
          {:error, "Unauthorized"}
        else
          cond do
            order.status == "filled" ->
              {:error, "Order cannot be cancelled once completed"}

            order.status == "cancelled" ->
              {:error, "Order already cancelled"}

            true ->
              Settings.update_secondary_market_order(order, %{status: "cancelled"})
              {:ok, order}
          end
        end
    end
  end

  @doc """
  Get market depth for an asset.
  """
  def get_market_depth(asset_id) do
    sell_orders = Settings.get_active_sell_orders(asset_id, 10)
    buy_orders = Settings.get_active_buy_orders(asset_id, 10)

    %{
      sell_orders: sell_orders,
      buy_orders: buy_orders
    }
  end

  @doc """
  Get recent trades for an asset.
  """
  def get_recent_trades(asset_id, limit \\ 20) do
    from(t in SecondaryMarketTrade,
      where: t.asset_id == ^asset_id,
      order_by: [desc: t.trade_date],
      limit: ^limit,
      preload: [:buyer, :seller, :asset]
    )
    |> Repo.all()
    |> Enum.map(&BluePotion.sanitize_struct(&1))
  end
end
