alias CommerceFront.{Repo, Settings}
alias CommerceFront.Market.Secondary
alias CommerceFront.Settings.{SecondaryMarketOrder, AssetTranche, Ewallet, WalletTransaction}
import Ecto.Query

# Configuration
asset_id = 1

IO.puts("Starting buy-off process...")

# 1. Get users by ID (verified via SQL)
prathum_id = 73
finance_id = 38

prathum = Repo.get(CommerceFront.Settings.User, prathum_id)
finance = Repo.get(CommerceFront.Settings.User, finance_id)

if is_nil(prathum) or is_nil(finance) do
  IO.puts("Error: Could not find one of the users by ID (#{prathum_id}, #{finance_id}).")
  System.halt(1)
end

IO.puts("Prathum Username: #{prathum.username}")
IO.puts("Finance Username: #{finance.username}")

# 2. Merge duplicate token wallets for finance user if they exist
token_wallets =
  Repo.all(
    from(e in Ewallet,
      where: e.user_id == ^finance.id and e.wallet_type == "token",
      order_by: [asc: e.id]
    )
  )

if length(token_wallets) > 1 do
  IO.puts("Found multiple token wallets for finance user. Merging...")
  [main_wallet | others] = token_wallets
  total_to_transfer = Enum.reduce(others, 0, fn w, acc -> acc + w.total end)

  if total_to_transfer > 0 do
    # Simple update for this script context
    Repo.update_all(from(e in Ewallet, where: e.id == ^main_wallet.id),
      inc: [total: total_to_transfer]
    )
  end

  for other <- others do
    # Move all transactions to the main wallet first to satisfy foreign key constraints
    Repo.update_all(from(wt in WalletTransaction, where: wt.ewallet_id == ^other.id),
      set: [ewallet_id: main_wallet.id]
    )

    # Now we can delete it
    Repo.delete!(other)
  end

  IO.puts(
    "Moved funds and transactions to wallet #{main_wallet.id} and deleted #{length(others)} duplicate wallets."
  )
end

# 3. Find Prathum's pending sell order for the asset
sell_order =
  Repo.one(
    from(o in SecondaryMarketOrder,
      where:
        o.user_id == ^prathum.id and o.order_type == "sell" and o.status == "pending" and
          o.asset_id == ^asset_id,
      order_by: [asc: o.inserted_at],
      limit: 1
    )
  )

if is_nil(sell_order) do
  IO.puts("Error: No pending sell order found for Prathum.")
  System.halt(1)
end

remaining_qty = sell_order.remaining_quantity
price = sell_order.price_per_unit

IO.puts("Found Sell Order #{sell_order.id}")
IO.puts("Remaining Qty: #{remaining_qty}")
IO.puts("Price: #{price}")

# 3. Double check tranche price
current_tranche = Secondary.get_current_open_tranche(asset_id)

if is_nil(current_tranche) do
  IO.puts("Error: No open tranche found.")
  System.halt(1)
end

if Decimal.compare(price, current_tranche.unit_price) != :eq do
  IO.puts(
    "Warning: Order price (#{price}) does not match current tranche price (#{current_tranche.unit_price})."
  )

  # Procedding anyway if create_buy_order enforces it, it might fail, but let's see.
end

# 4. Execute buy order from finance
# Calculating exact cost and rounding UP to 3 decimal places
# to ensure we cover the amount after create_buy_order's internal round(3, :down)
exact_cost = Decimal.mult(remaining_qty, price) |> Decimal.round(3, :up)
IO.puts("Executing buy order for #{remaining_qty} from finance (Cost: #{exact_cost})...")

case Secondary.create_buy_order(finance.id, asset_id, remaining_qty, price, exact_cost) do
  {:ok, order} ->
    IO.puts("Success! Buy order created: #{order.id}")
    # Verification
    updated_sell_order = Repo.get(SecondaryMarketOrder, sell_order.id)
    IO.puts("Updated Sell Order Status: #{updated_sell_order.status}")
    IO.puts("Updated Sell Order Remaining Qty: #{updated_sell_order.remaining_quantity}")

  {:error, reason} ->
    IO.puts("Error executing buy order: #{inspect(reason)}")
end
