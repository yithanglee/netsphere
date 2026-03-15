defmodule CommerceFront.Repo.Migrations.CreateSwapBackTxChecks do
  use Ecto.Migration

  def change do
    create table(:swap_back_tx_checks) do
      add :swap_back_id, references(:swap_backs, on_delete: :delete_all), null: false
      add :tx_hash, :string, null: false
      add :status, :string, null: false, default: "pending"
      add :last_checked_at, :utc_datetime
      add :confirmed_at, :utc_datetime
      add :check_count, :integer, null: false, default: 0
      add :last_error, :string

      timestamps()
    end

    create unique_index(:swap_back_tx_checks, [:swap_back_id])
    create index(:swap_back_tx_checks, [:status])
  end
end
