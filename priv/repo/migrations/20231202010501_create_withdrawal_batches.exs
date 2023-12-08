defmodule CommerceFront.Repo.Migrations.CreateWithdrawalBatches do
  use Ecto.Migration

  def change do
    create table(:withdrawal_batches) do
      add :day, :integer
      add :month, :integer
      add :year, :integer
      add :remarks, :binary
      add :is_open, :boolean, default: false, null: false
      timestamps()
    end

  end
end
