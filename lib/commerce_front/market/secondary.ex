defmodule CommerceFront.Market.Secondary do
  @moduledoc """
  Secondary market for trading active_token assets between users.
  """

  import Ecto.Query
  alias CommerceFront.{Repo, Settings}
  alias CommerceFront.Settings.{
    SecondaryMarketOrder,
    SecondaryMarketTrade,
    WalletTransaction,
    Ewallet
  }
  require Decimal

  @doc """
  Create a sell order for active_token assets.
  """
  def create_sell_order(user_id, asset_id, quantity, price_per_unit) do
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

  @doc """
  Create a buy order for active_token assets.
  """
  def create_buy_order(user_id, asset_id, quantity, price_per_unit) do
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

      with {:ok, order} <- Settings.create_secondary_market_order(order_params) do
        # Try to match with existing sell orders
        match_and_execute_trades(order)
        {:ok, order}
      end
    end
  end

  @doc """
  Match a new order with existing orders and execute trades.
  """
  def match_and_execute_trades(new_order) do
    case new_order.order_type do
      "buy" -> match_buy_order_with_sells(new_order)
      "sell" -> match_sell_order_with_buys(new_order)
    end
  end

  defp match_buy_order_with_sells(buy_order) do
    # Get sell orders with price <= buy order price, sorted by lowest price first
    sell_orders = from(o in SecondaryMarketOrder,
      where: o.asset_id == ^buy_order.asset_id and
             o.order_type == "sell" and
             o.status == "pending" and
             o.price_per_unit <= ^buy_order.price_per_unit and
             o.user_id != ^buy_order.user_id,
      order_by: [asc: o.price_per_unit, asc: o.inserted_at]
    ) |> Repo.all()

    execute_trades(buy_order, sell_orders)
  end

  defp match_sell_order_with_buys(sell_order) do
    # Get buy orders with price >= sell order price, sorted by highest price first
    buy_orders = from(o in SecondaryMarketOrder,
      where: o.asset_id == ^sell_order.asset_id and
             o.order_type == "buy" and
             o.status == "pending" and
             o.price_per_unit >= ^sell_order.price_per_unit and
             o.user_id != ^sell_order.user_id,
      order_by: [desc: o.price_per_unit, desc: o.inserted_at]
    ) |> Repo.all()

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
          trade_price = matching_order.price_per_unit  # Use the matching order's price (better for the new order)
          trade_amount = Decimal.mult(trade_quantity, trade_price)

          # Create the trade
          trade_params = %{
            buy_order_id: (if main_order.order_type == "buy", do: main_order.id, else: matching_order.id),
            sell_order_id: (if main_order.order_type == "sell", do: main_order.id, else: matching_order.id),
            buyer_id: (if main_order.order_type == "buy", do: main_order.user_id, else: matching_order.user_id),
            seller_id: (if main_order.order_type == "sell", do: main_order.user_id, else: matching_order.user_id),
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
    with {:ok, _trade} <- Settings.create_secondary_market_trade(trade_params),
         {:ok, _} <- execute_wallet_transfers(trade_params) do

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
    # Transfer tokens from buyer to seller
    token_transfer_params = %{
      user_id: trade_params.buyer_id,
      amount: -Decimal.to_float(trade_params.total_amount),
      remarks: "secondary_market_buy_#{trade_params.asset_id}_#{trade_params.trade_date}",
      wallet_type: "token"
    }

    # Transfer active_token from seller to buyer
    active_token_transfer_params = %{
      user_id: trade_params.seller_id,
      amount: -Decimal.to_float(trade_params.quantity),
      remarks: "secondary_market_sell_#{trade_params.asset_id}_#{trade_params.trade_date}",
      wallet_type: "active_token"
    }

    # Add active_token to buyer
    buyer_token_params = %{
      user_id: trade_params.buyer_id,
      amount: Decimal.to_float(trade_params.quantity),
      remarks: "secondary_market_receive_#{trade_params.asset_id}_#{trade_params.trade_date}",
      wallet_type: "active_token"
    }

    # Add tokens to seller
    seller_token_params = %{
      user_id: trade_params.seller_id,
      amount: Decimal.to_float(trade_params.total_amount),
      remarks: "secondary_market_receive_tokens_#{trade_params.asset_id}_#{trade_params.trade_date}",
      wallet_type: "token"
    }

    with {:ok, _} <- Settings.create_wallet_transaction(token_transfer_params),
         {:ok, _} <- Settings.create_wallet_transaction(active_token_transfer_params),
         {:ok, _} <- Settings.create_wallet_transaction(buyer_token_params),
         {:ok, _} <- Settings.create_wallet_transaction(seller_token_params) do
      {:ok, :success}
    else
      error -> {:error, "Wallet transfer failed: #{inspect(error)}"}
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
      nil -> {:error, "Order not found"}
      order ->
        if order.user_id != user_id do
          {:error, "Unauthorized"}
        else
          case order.status do
            "pending" ->
              Settings.update_secondary_market_order(order, %{status: "cancelled"})
              {:ok, order}
            _ ->
              {:error, "Order cannot be cancelled"}
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
