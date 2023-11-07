defmodule CommerceFront.Repo.Migrations.CreateWalletTransactions do
  use Ecto.Migration

  def change do
    create table(:wallet_transactions) do
      add :before, :float
      add :after, :float
      add :amount, :float
      add :remarks, :binary
      add :user_id, references(:users)
add :ewallet_id, references(:ewallets)
      timestamps()
    end

  end
end
