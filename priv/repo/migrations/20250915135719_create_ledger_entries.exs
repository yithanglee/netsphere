defmodule CommerceFront.Repo.Migrations.CreateLedgerEntries do
  use Ecto.Migration

  def change do
    create table(:ledger_entries) do
      add :journal, :string, null: false
      add :currency, :string, null: false, default: "USD"
      add :amount, :decimal, null: false
      add :direction, :string, null: false
      add :reference, :map, null: false, default: %{}
      add :user_id, references(:users, on_delete: :delete_all)
      add :asset_id, references(:assets, on_delete: :delete_all)

      timestamps(updated_at: false)
    end

    create index(:ledger_entries, [:user_id])
    create index(:ledger_entries, [:asset_id])
  end
end
