defmodule CommerceFront.Repo.Migrations.CreateSecondaryMarketOrders do
  use Ecto.Migration

  def change do
    create table(:secondary_market_orders) do
      add :user_id, references(:users, on_delete: :delete_all), null: false
      add :order_type, :string, null: false  # "buy" or "sell"
      add :asset_id, references(:assets, on_delete: :delete_all), null: false
      add :quantity, :decimal, null: false
      add :price_per_unit, :decimal, null: false
      add :total_amount, :decimal, null: false
      add :status, :string, null: false, default: "pending"  # pending, filled, cancelled
      add :filled_quantity, :decimal, null: false, default: 0
      add :remaining_quantity, :decimal, null: false

      timestamps()
    end

    create index(:secondary_market_orders, [:user_id])
    create index(:secondary_market_orders, [:asset_id])
    create index(:secondary_market_orders, [:order_type])
    create index(:secondary_market_orders, [:status])
    create index(:secondary_market_orders, [:price_per_unit])
    create index(:secondary_market_orders, [:inserted_at])
  end
end
