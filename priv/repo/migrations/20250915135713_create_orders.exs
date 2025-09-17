defmodule CommerceFront.Repo.Migrations.CreateOrders do
  use Ecto.Migration

  def change do
    create table(:orders) do
      add :side, :string, null: false
      add :source, :string, null: false, default: "primary"
      add :order_type, :string, null: false, default: "market"
      add :qty, :decimal, null: false
      add :qty_filled, :decimal, null: false, default: 0
      add :price, :decimal
      add :status, :string, null: false, default: "open"
      add :idempotency_key, :string
      add :meta, :map, null: false, default: %{}
      add :user_id, references(:users, on_delete: :delete_all), null: false
      add :asset_id, references(:assets, on_delete: :delete_all), null: false

      timestamps()
    end

    create index(:orders, [:user_id])
    create index(:orders, [:asset_id])
    create unique_index(:orders, [:user_id, :idempotency_key], name: :orders_idemp_unique)
  end
end
