defmodule CommerceFront.Repo.Migrations.CreateHoldings do
  use Ecto.Migration

  def change do
    create table(:holdings) do
      add :quantity, :decimal, null: false, default: 0
      add :locked, :decimal, null: false, default: 0
      add :average_price, :decimal, null: false, default: 0
      add :user_id, references(:users, on_delete: :delete_all), null: false
      add :asset_id, references(:assets, on_delete: :delete_all), null: false

      timestamps()
    end

    create index(:holdings, [:user_id])
    create index(:holdings, [:asset_id])
    create unique_index(:holdings, [:user_id, :asset_id])
  end
end
