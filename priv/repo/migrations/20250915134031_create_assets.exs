defmodule CommerceFront.Repo.Migrations.CreateAssets do
  use Ecto.Migration

  def change do
    create table(:assets) do
      add :symbol, :string
      add :name, :string
      add :decimals, :integer, default: 6
      add :base_price, :decimal
      add :price_increment_type, :string, default: "fixed_amount"
      add :price_increment_value, :decimal
      add :min_order_qty, :decimal, default: 1.0
      add :status, :string, default: "draft"
      add :total_supply_cap, :decimal

      timestamps()
    end

    create unique_index(:assets, [:symbol])
  end
end
