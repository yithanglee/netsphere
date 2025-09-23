defmodule CommerceFront.Repo.Migrations.CreateStakeHoldings do
  use Ecto.Migration

  def change do
    create table(:stake_holdings) do
      add :holding_id, references(:holdings, on_delete: :delete_all), null: false
      add :original_qty, :decimal, null: false
      add :initial_bought, :date, null: false
      add :released, :decimal, null: false, default: 0

      timestamps()
    end

    create index(:stake_holdings, [:holding_id])
    create index(:stake_holdings, [:initial_bought])
  end
end
