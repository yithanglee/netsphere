defmodule CommerceFront.Repo.Migrations.CreateAssetTranches do
  use Ecto.Migration

  def change do
    create table(:asset_tranches) do
      add :seq, :integer, null: false
      add :quantity, :decimal, null: false
      add :qty_sold, :decimal, null: false, default: 0
      add :unit_price, :decimal, null: false
      add :state, :string, null: false, default: "upcoming"
      add :released_at, :utc_datetime_usec
      add :asset_id, references(:assets, on_delete: :delete_all), null: false

      timestamps()
    end

    create index(:asset_tranches, [:asset_id])
    create unique_index(:asset_tranches, [:asset_id, :seq])
    create constraint(:asset_tranches, :tranche_not_oversold, check: "qty_sold <= quantity")
  end
end
