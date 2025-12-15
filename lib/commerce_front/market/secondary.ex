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
    StakeHolding,
    Ewallet
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
  Calculate how much quantity can be purchased with a given token budget across tranches.
  Step-by-step approach:
  1. Get available quantity in current tranche
  2. Calculate max quantity buyable with token budget at current tranche price
  3. Take minimum of (available, affordable)
  4. If there's remaining budget, move to next tranche and repeat

  Returns {:ok, total_qty, total_cost, tranches_breakdown} or {:error, reason}.
  """
  def calculate_quantity_from_budget(asset_id, token_budget) do
    # Get current open tranche first
    case get_current_open_tranche(asset_id) do
      nil ->
        {:error, "No open tranche available"}

      current_tranche ->
        # Get all tranches starting from current
        tranches =
          from(t in AssetTranche,
            where: t.asset_id == ^asset_id and t.seq >= ^current_tranche.seq,
            order_by: [asc: t.seq]
          )
          |> Repo.all()

        calculate_budget_recursive(tranches, token_budget, Decimal.new("0"), Decimal.new("0"), [])
        |> IO.inspect(label: "calculate_budget_recursive result")
    end
  end

  defp calculate_budget_recursive([], _remaining_budget, total_qty, total_spent, breakdown) do
    # No more tranches available
    if Decimal.compare(total_qty, Decimal.new("0")) == :gt do
      {:ok, total_qty, total_spent, Enum.reverse(breakdown)}
    else
      {:error, "No tranches available or insufficient budget"}
    end
  end

  defp calculate_budget_recursive(
         [tranche | rest],
         remaining_budget,
         total_qty,
         total_spent,
         breakdown
       ) do
    # Stop if budget is exhausted
    if Decimal.compare(remaining_budget, Decimal.new("0")) in [:lt, :eq] do
      {:ok, total_qty, total_spent, Enum.reverse(breakdown)}
    else
      # Step 1: Get available quantity in this tranche
      available_in_tranche =
        Decimal.sub(tranche.quantity, tranche.traded_qty)
        |> IO.inspect(label: "available_in_tranche #{tranche.seq}")

      # Step 2: Calculate max quantity buyable with remaining budget at this tranche price
      max_qty_from_budget =
        Decimal.div(remaining_budget, tranche.unit_price)
        |> IO.inspect(label: "max_qty_from_budget at price #{tranche.unit_price}")

      # Step 3: Take minimum (can't buy more than available, can't buy more than affordable)
      qty_from_this_tranche =
        Decimal.min(max_qty_from_budget, available_in_tranche)
        |> IO.inspect(label: "qty_from_this_tranche #{tranche.seq}")

      # Calculate actual cost for this quantity
      cost_from_this_tranche =
        Decimal.mult(qty_from_this_tranche, tranche.unit_price)
        |> IO.inspect(label: "cost_from_this_tranche")

      # Step 4: Calculate remainder
      new_remaining_budget =
        Decimal.sub(remaining_budget, cost_from_this_tranche)
        |> IO.inspect(label: "new_remaining_budget")

      new_total_qty = Decimal.add(total_qty, qty_from_this_tranche)
      new_total_spent = Decimal.add(total_spent, cost_from_this_tranche)
      new_breakdown = [{tranche, qty_from_this_tranche, cost_from_this_tranche} | breakdown]

      # Step 5: If there's remaining budget and quantity from this tranche > 0, try next tranche
      if Decimal.compare(new_remaining_budget, Decimal.new("0")) == :gt and
           Decimal.compare(qty_from_this_tranche, Decimal.new("0")) == :gt do
        # Still have budget, try next tranche
        calculate_budget_recursive(
          rest,
          new_remaining_budget,
          new_total_qty,
          new_total_spent,
          new_breakdown
        )
      else
        # Budget exhausted or couldn't buy anything from this tranche
        {:ok, new_total_qty, new_total_spent, Enum.reverse(new_breakdown)}
      end
    end
  end

  @doc """
  Update the sold quantity for a tranche.
  """
  def update_tranche_sold_quantity(tranche_id, additional_qty) do
    tranche = Repo.get!(AssetTranche, tranche_id)
    qty_sold = Decimal.add(tranche.qty_sold, additional_qty)

    Settings.update_asset_tranche(tranche, %{
      qty_sold: qty_sold
    })
  end

  def update_tranche_traded_quantity(tranche_id, additional_qty) do
    tranche = Repo.get!(AssetTranche, tranche_id)

    Settings.update_asset_tranche(tranche, %{
      traded_qty: Decimal.add(tranche.traded_qty, additional_qty)
    })
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

  # todo check the compare 2 types
  defp close_tranche_if_filled(%AssetTranche{} = tranche) do
    if Decimal.compare(tranche.traded_qty, tranche.quantity) != :lt do
      # Close current tranche
      _ =
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

      with true <- next != nil,
           {:ok, next_tranche} <-
             Settings.update_asset_tranche(next, %{state: "open", released_at: DateTime.utc_now()}) do
        {:closed, next_tranche}
      else
        nil ->
          {:closed, nil}
      end
    else
      {:open, nil}
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

    total_sales_by_members =
      CommerceFront.Repo.all(
        from(s in CommerceFront.Settings.Sale,
          where: s.user_id == ^user_id,
          group_by: s.user_id,
          select: sum(s.subtotal)
        )
      )
      |> List.first()

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

    existing_sell_amount =
      from(o in SecondaryMarketOrder,
        where:
          o.user_id == ^user_id and
            o.asset_id == ^asset_id and
            o.order_type == "sell" and
            o.status == "filled",
        select: sum(o.total_amount)
      )
      |> Repo.one()
      |> case do
        nil -> Decimal.new("0")
        amount -> amount
      end

    total_amount = Decimal.mult(quantity, price_per_unit)

    if !Settings.unit_price_valid?(price_per_unit) do
      {:error, "Invalid unit price. Please use a valid unit price."}
    else
      if existing_active_sell_count > 0 do
        {:error, "You already have an active sell order for this asset"}
      else
        # Check if user has sufficient active_token balance
        unless Settings.has_sufficient_active_token_balance?(user_id, asset_id, quantity) do
          {:error, "Insufficient active_token balance"}
        else
          current_sell_limit = (total_sales_by_members * 0.5) |> Decimal.from_float()
          upcoming_sell_amount = Decimal.add(Decimal.new("0"), total_amount)
          remaining_sell_limit = Decimal.sub(current_sell_limit, existing_sell_amount)

          if Decimal.to_float(upcoming_sell_amount) > Decimal.to_float(current_sell_limit) do
            {:error,
             "You have reached the sell limit. You can only sell up to #{current_sell_limit} tokens. Balance: #{remaining_sell_limit}. Selling #{total_amount}, #{upcoming_sell_amount}"}
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
    end
  end

  @doc """
  Create a buy order for active_token assets.
  Now enforces tranche pricing - buy orders must be at current tranche price.
  Uses budget-based calculation to determine affordable quantity across multiple tranches.

  Example: CommerceFront.Market.Secondary.create_buy_order(68, 1, 27.2727, 0.0011, 0.03)

  When member_token_amount is provided, it's used as the budget instead of user's current balance.
  """
  def create_buy_order(user_id, asset_id, quantity, price_per_unit, member_token_amount \\ nil) do
    # First, get the current open tranche to enforce pricing
    IO.inspect([user_id, price_per_unit, member_token_amount], label: "create_buy_order")

    case get_current_open_tranche(asset_id) |> IO.inspect(label: "get_current_open_tranche") do
      nil ->
        {:error, "No open tranche available for this asset"}

      current_tranche ->
        # Enforce tranche pricing - buy orders must match current tranche price
        if Decimal.compare(price_per_unit, current_tranche.unit_price) != :eq do
          {:error, "Buy orders must be at current tranche price: #{current_tranche.unit_price}"}
        else
          # Get user's token budget (use member_token_amount if provided, otherwise get balance)
          token_budget =
            if member_token_amount do
              case member_token_amount do
                %Decimal{} -> member_token_amount
                _ -> Decimal.new("#{member_token_amount}")
              end
            else
              Settings.get_user_token_balance(user_id)
            end
            |> IO.inspect(label: "token_budget")

          if Decimal.compare(token_budget, Decimal.new("0")) == :gt do
            # Calculate how much quantity can be purchased with available budget across tranches
            case calculate_quantity_from_budget(asset_id, token_budget) do
              {:ok, affordable_qty, actual_cost, breakdown} ->
                IO.inspect(affordable_qty, label: "affordable_qty")
                IO.inspect(actual_cost, label: "actual_cost")
                IO.inspect(breakdown, label: "breakdown")

                pre_quantity =
                  breakdown
                  |> Enum.filter(&(elem(&1, 0).unit_price == price_per_unit))
                  |> List.first()

                if pre_quantity != nil do
                  quantity =
                    pre_quantity
                    |> elem(1)

                  remainder_breakdowns =
                    breakdown |> Enum.filter(&(elem(&1, 0).unit_price != price_per_unit))

                  # Check if user can afford the requested quantity
                  if Decimal.compare(quantity, affordable_qty) == :gt do
                    {:error,
                     "Insufficient token balance. You have #{token_budget} tokens, which can buy #{affordable_qty} units (costing #{actual_cost}), but you requested #{quantity} units."}
                  else
                    # User can afford it - create the order
                    # Use the simple calculation for the order record (for consistency with current tranche price)
                    total_amount = Decimal.mult(quantity, price_per_unit)

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

                    with {:ok, order} <-
                           Settings.create_secondary_market_order(order_params)
                           |> IO.inspect(label: "market order") do
                      # Try to match with existing sell orders or inject liquidity

                      _trade_res =
                        match_and_execute_tranche_based_trades(
                          order,
                          current_tranche,
                          remainder_breakdowns
                        )
                        |> IO.inspect(label: "trade_res")

                      {:ok, order}
                    end
                  end
                else
                  {:error,
                   "Insufficient token balance. You have #{token_budget} tokens, but you requested #{quantity} units."}
                end

              {:error, reason} ->
                {:error,
                 "Cannot calculate affordable quantity: #{reason}. Token budget: #{token_budget}"}
            end
          else
            {:error,
             "Insufficient token balance. You have #{token_budget} tokens, but you requested #{quantity} units."}
          end
        end
    end
    |> IO.inspect(label: "create_buy_order")
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
  def match_and_execute_tranche_based_trades(buy_order, current_tranche, remainder_breakdowns) do
    # Only handle buy orders with this new logic
    case buy_order.order_type do
      "buy" ->
        match_buy_order_with_tranche_rules(buy_order, current_tranche, remainder_breakdowns)

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
  defp match_buy_order_with_tranche_rules(buy_order, current_tranche, remainder_breakdowns) do
    IO.inspect(buy_order, label: "buy_order")
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
    {remaining_after_member_trades, post_current_tranche} =
      execute_member_trades(buy_order, member_sell_orders, remaining_to_fill, current_tranche)
      |> IO.inspect(label: "remaining_after_member_trades")

    # buy kampiew's 1000 qty first, see the remainder...

    # Step 3: If still need to fill, inject from tranche
    _tranche_res =
      if Decimal.compare(remaining_after_member_trades, Decimal.new("0")) == :gt do
        inject_from_tranche(buy_order, post_current_tranche, remaining_after_member_trades)
        |> IO.inspect(label: "remaining_after_inject_from_tranche")
      end

    # Step 4: Update order status
    updated_buy_order = Repo.get!(SecondaryMarketOrder, buy_order.id)

    if Decimal.compare(updated_buy_order.remaining_quantity, Decimal.new("0")) == :eq do
      update_order_status(buy_order, "filled")
    end

    # here should check if there's remainder token unused...

    # Step 5: If tranche filled, close and open next
    tranche = Repo.get!(AssetTranche, current_tranche.id)
    {_tranche_status, next_tranche} = close_tranche_if_filled(tranche)

    if remainder_breakdowns != [] do
      remainder = List.first(remainder_breakdowns)

      if remainder != nil && next_tranche != nil do
        create_buy_order(
          buy_order.user_id,
          buy_order.asset_id,
          remainder |> elem(1) |> Decimal.round(5),
          next_tranche.unit_price
        )
      end
    else
      # need to put back pending wallet executed tokens.........
      # Settings.get_outstanding_token_buys()
    end
  end

  defp execute_member_trades(
         buy_order,
         sell_orders,
         remaining_quantity,
         continuous_current_tranche
       ) do
    Enum.reduce_while(
      sell_orders,
      {remaining_quantity, continuous_current_tranche},
      fn sell_order, {remaining, post_current_tranche} ->
        if Decimal.compare(remaining, Decimal.new("0")) == :eq do
          {:halt, {remaining, post_current_tranche}}
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

          case execute_trade(trade_params, buy_order, sell_order, post_current_tranche) do
            {:ok, _, post_current_tranche} ->
              new_remaining = Decimal.sub(remaining, trade_quantity)

              {:cont, {new_remaining, post_current_tranche}}

            {:error, _} ->
              {:halt, {remaining, post_current_tranche}}
          end
        end
      end
    )
  end

  @doc """
  Inject synthetic sell orders from tranche to fulfill buy orders.
  """
  def inject_from_tranche(buy_order, current_tranche, needed_quantity) do
    # Refresh tranche to avoid stale qty_sold/traded_qty

    tranche = Repo.get!(AssetTranche, current_tranche.id)

    # Caps: total remaining and company remaining
    available_total = Decimal.sub(tranche.quantity, tranche.traded_qty)
    _available_company = Decimal.sub(tranche.quantity, tranche.qty_sold)

    # damien: difficult to tell, actually need the backfill function and get last traded quantity after amount.
    # as long as the backfill function the
    # Determine how much we can inject from current tranche (respect both caps)
    injection_quantity =
      needed_quantity
      |> Decimal.min(available_total)

    if Decimal.compare(injection_quantity, Decimal.new("0")) == :gt do
      # Inject synthetic sell order
      case inject_synthetic_sell_order(
             buy_order.asset_id,
             injection_quantity,
             tranche.unit_price,
             buy_order.user_id
           ) do
        {:ok, {_synthetic_order, trade_params}} ->
          # Update trade params with buy order ID
          trade_params = Map.put(trade_params, :buy_order_id, buy_order.id)

          # Execute the trade
          case execute_synthetic_trade(trade_params, buy_order, tranche) do
            {:ok, _} ->
              # Update tranche sold quantity
              IO.inspect(injection_quantity, label: "injection_quantity")
              update1 = update_tranche_sold_quantity(tranche.id, injection_quantity)
              update2 = update_tranche_traded_quantity(tranche.id, injection_quantity)

              with {:ok, updated_tranche1} <- update1,
                   # Update total traded quantity (includes company injection)
                   {:ok, updated_tranche2} <- update2 do
                # TODO: Cross-tranche fulfillment disabled to avoid nested transaction wallet lock issues.
                # To support cross-tranche orders, refactor to loop within match_buy_order_with_tranche_rules
                # and aggregate all fills before a single wallet deduction.
                remaining_after_injection = Decimal.sub(needed_quantity, injection_quantity)

                if Decimal.compare(remaining_after_injection, Decimal.new("0")) == :gt do
                  IO.inspect(remaining_after_injection,
                    label: "remaining_unfilled_after_tranche_exhausted"
                  )

                  # Order remains partially filled; next matching cycle can try next tranche
                end

                # After injection, check if tranche is filled and rotate
                tranche = Repo.get(AssetTranche, tranche.id)
                close_tranche_if_filled(tranche)
              else
                _ ->
                  nil
                  {:error, "Failed to execute synthetic trade: oversold tranche}"}
              end

            {:error, reason} ->
              {:error, "Failed to execute synthetic trade: #{inspect(reason)}"}
          end

        {:error, reason} ->
          {:error, "Failed to inject synthetic order: #{inspect(reason)}"}
      end
    end
  end

  defp execute_synthetic_trade(trade_params, buy_order, tranche) do
    IO.inspect([trade_params, buy_order, tranche], label: "execute_synthetic_trade")

    with {:ok, wallet_tx_refs} <- execute_wallet_transfers(trade_params),
         {:ok, _trade} <-
           Settings.create_secondary_market_trade(Map.merge(trade_params, wallet_tx_refs)) do
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

  defp execute_trade(trade_params, main_order, matching_order, continuous_current_tranche \\ nil) do
    with {:ok, wallet_tx_refs} <-
           execute_wallet_transfers(trade_params, continuous_current_tranche),
         {:ok, _trade} <-
           Settings.create_secondary_market_trade(Map.merge(trade_params, wallet_tx_refs)) do
      # Update order quantities
      update_order_filled_quantity(main_order, trade_params.quantity)
      update_order_filled_quantity(matching_order, trade_params.quantity)

      # Check if matching order is now filled
      if Decimal.compare(matching_order.remaining_quantity, trade_params.quantity) == :eq do
        update_order_status(matching_order, "filled")
      end

      post_current_tranche =
        if continuous_current_tranche do
          case update_tranche_traded_quantity(
                 continuous_current_tranche.id,
                 trade_params.quantity
               )
               |> IO.inspect(label: "update_tranche_traded_quantity") do
            {:ok, updated_tranche} -> updated_tranche
            _ -> continuous_current_tranche
          end
        else
          nil
        end

      {:ok, :success, post_current_tranche}
    else
      error ->
        {:error, "Trade execution failed: #{inspect(error)}", continuous_current_tranche}
    end
  end

  defp execute_wallet_transfers(trade_params, continuous_current_tranche \\ nil) do
    _ = continuous_current_tranche
    IO.inspect(trade_params, label: "trade_params")
    finance_user = Settings.finance_user()
    is_synthetic_seller = trade_params.seller_id == finance_user.id

    # Precompute wallet transaction param maps
    buyer_token_debit = %{
      user_id: trade_params.buyer_id,
      amount: -Decimal.to_float(trade_params.total_amount) |> Float.round(3),
      remarks:
        "secondary_market_buy_#{trade_params.asset_id}_#{trade_params.trade_date} | qty: #{trade_params.quantity}",
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
      amount: (Decimal.to_float(trade_params.total_amount) * 0.3) |> Float.round(3),
      remarks:
        "secondary_market_receive_tokens_#{trade_params.asset_id}_#{trade_params.trade_date}| qty: #{trade_params.quantity}| total_amount: #{trade_params.total_amount}",
      wallet_type: "token"
    }

    seller_bonus_credit = %{
      user_id: trade_params.seller_id,
      amount: (Decimal.to_float(trade_params.total_amount) * 0.7) |> Float.round(3),
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
          |> IO.inspect(label: "bal")
        cond do
          is_nil(bal) ->
            {:error, :buyer_wallet_not_found}

          Decimal.compare(
              Decimal.from_float(bal.total),
            trade_params.total_amount |> Decimal.round(2)
          ) == :lt ->
            {:error, :insufficient_funds}

          true ->
            {:ok, bal}
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
        end
      end)

    case Repo.transaction(multi) |> IO.inspect(label: "multi results") do
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
            %{wallet_transaction: wt} ->
              if wt.user_id != CommerceFront.Settings.finance_user().id do
                CommerceFront.Settings.manual_create_buy_order(wt.user_id, wt.amount)
              end

              Map.put(refs, :seller_token_tx_id, wt.id)

            _ ->
              refs
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
      order_by: [desc: t.trade_date, desc: t.id],
      limit: ^limit,
      preload: [:buyer, :seller, :asset]
    )
    |> Repo.all()
    |> Enum.map(&BluePotion.sanitize_struct(&1))
  end
end
