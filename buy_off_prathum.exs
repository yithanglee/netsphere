alias CommerceFront.{Repo, Settings}
alias CommerceFront.Market.Secondary
alias CommerceFront.Settings.{SecondaryMarketOrder, AssetTranche, Ewallet, WalletTransaction}
import Ecto.Query

# Configuration
asset_id = 1
# Target users to buy off
# Chalida (61), Prathum (73) is already filled
target_user_ids = [61]
finance_id = 38

IO.puts("Starting multi-user buy-off process...")

finance = Repo.get(Settings.User, finance_id)

if is_nil(finance) do
  IO.puts("Error: Could not find finance user ID #{finance_id}.")
  System.halt(1)
end

# 1. Merge duplicate token wallets for finance user if they exist
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
    Repo.update_all(from(e in Ewallet, where: e.id == ^main_wallet.id),
      inc: [total: total_to_transfer]
    )
  end

  for other <- others do
    Repo.update_all(from(wt in WalletTransaction, where: wt.ewallet_id == ^other.id),
      set: [ewallet_id: main_wallet.id]
    )

    Repo.delete!(other)
  end

  IO.puts(
    "Moved funds and transactions to wallet #{main_wallet.id} and deleted #{length(others)} duplicate wallets."
  )
end

# 2. Process each target user
for user_id <- target_user_ids do
  user = Repo.get(Settings.User, user_id)

  if is_nil(user) do
    IO.puts("\n--- User ID #{user_id} not found, skipping ---")
  else
    IO.puts("\n--- Processing User: #{user.username} (ID: #{user_id}) ---")

    sell_orders =
      Repo.all(
        from(o in SecondaryMarketOrder,
          where:
            o.user_id == ^user.id and o.order_type == "sell" and o.status == "pending" and
              o.asset_id == ^asset_id,
          order_by: [asc: o.inserted_at]
        )
      )

    if Enum.empty?(sell_orders) do
      IO.puts("No pending sell orders found for #{user.username}.")
    else
      for sell_order <- sell_orders do
        remaining_qty = sell_order.remaining_quantity
        price = sell_order.price_per_unit

        IO.puts("Found Sell Order #{sell_order.id}, Qty: #{remaining_qty}, Price: #{price}")

        # Execute buy order from finance
        exact_cost = Decimal.mult(remaining_qty, price) |> Decimal.round(3, :up)
        IO.puts("Executing buy order from finance (Cost: #{exact_cost})...")

        case Secondary.create_buy_order(finance.id, asset_id, remaining_qty, price, exact_cost) do
          {:ok, order} ->
            IO.puts("Success! Created buy order: #{order.id}")

            # Cancel leftover if pending
            o = Repo.get(SecondaryMarketOrder, order.id)

            if o.status == "pending" do
              IO.puts("Cancelling leftover portion of buy order #{o.id}...")
              Secondary.cancel_order(o.id, finance.id)
            end

            updated_sell = Repo.get(SecondaryMarketOrder, sell_order.id)

            IO.puts(
              "Updated Sell Order #{sell_order.id} Status: #{updated_sell.status}, Left: #{updated_sell.remaining_quantity}"
            )

          {:error, reason} ->
            IO.puts("Error executing buy order for #{user.username}: #{inspect(reason)}")
        end
      end
    end
  end
end

IO.puts("\nAll specified users processed.")
