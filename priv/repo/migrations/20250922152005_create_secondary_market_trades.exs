defmodule CommerceFront.Repo.Migrations.CreateSecondaryMarketTrades do
  use Ecto.Migration

  def change do
    create table(:secondary_market_trades) do
      add :buy_order_id, references(:secondary_market_orders, on_delete: :nilify_all)
      add :sell_order_id, references(:secondary_market_orders, on_delete: :nilify_all)
      add :buyer_id, references(:users, on_delete: :delete_all), null: false
      add :seller_id, references(:users, on_delete: :delete_all), null: false
      add :asset_id, references(:assets, on_delete: :delete_all), null: false
      add :quantity, :decimal, null: false
      add :price_per_unit, :decimal, null: false
      add :total_amount, :decimal, null: false
      add :trade_date, :utc_datetime, null: false

      timestamps()
    end

    create index(:secondary_market_trades, [:buyer_id])
    create index(:secondary_market_trades, [:seller_id])
    create index(:secondary_market_trades, [:asset_id])
    create index(:secondary_market_trades, [:trade_date])
    create index(:secondary_market_trades, [:buy_order_id])
    create index(:secondary_market_trades, [:sell_order_id])
  end
end
