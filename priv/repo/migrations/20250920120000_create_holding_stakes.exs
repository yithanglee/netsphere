defmodule CommerceFront.Repo.Migrations.CreateHoldingStakes do
  use Ecto.Migration

  def change do
    # create table(:holding_stakes) do
    #   add :user_id, references(:users, on_delete: :delete_all), null: false
    #   add :asset_id, references(:assets, on_delete: :delete_all), null: false
    #   add :original_qty, :decimal, null: false
    #   add :remaining_locked_qty, :decimal, null: false
    #   add :daily_release_qty, :decimal, null: false
    #   add :days_total, :integer, null: false, default: 100
    #   add :days_released, :integer, null: false, default: 0
    #   add :last_release_date, :date
    #   add :status, :string, null: false, default: "active"

    #   timestamps()
    # end

    # create index(:holding_stakes, [:user_id])
    # create index(:holding_stakes, [:asset_id])
    # create index(:holding_stakes, [:status])
  end
end


