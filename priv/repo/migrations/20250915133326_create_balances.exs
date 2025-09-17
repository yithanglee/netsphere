defmodule CommerceFront.Repo.Migrations.CreateBalances do
  use Ecto.Migration

  def change do
    create table(:balances) do
      add :user_id, references(:users)
      add :currency, :string
      add :available, :decimal
      add :locked, :decimal

      timestamps()
    end

  end
end
