defmodule CommerceFront.Repo.Migrations.CreateTrades do
  use Ecto.Migration

  def change do
    create table(:trades) do
      add :side, :string, null: false, default: "primary"
      add :price, :decimal, null: false
      add :qty, :decimal, null: false
      add :fees_bps, :integer, null: false, default: 0
      add :fees_amount, :decimal, null: false, default: 0
      add :asset_id, references(:assets, on_delete: :delete_all), null: false
      add :buyer_order_id, references(:orders, on_delete: :nilify_all)
      add :seller_order_id, references(:orders, on_delete: :nilify_all)
      add :tranche_id, references(:asset_tranches, on_delete: :nilify_all)

      timestamps(updated_at: false)
    end

    create index(:trades, [:asset_id])
    create index(:trades, [:buyer_order_id])
    create index(:trades, [:seller_order_id])
    create index(:trades, [:tranche_id])
  end
end
