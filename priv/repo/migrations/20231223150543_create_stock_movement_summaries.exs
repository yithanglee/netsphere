defmodule CommerceFront.Repo.Migrations.CreateStockMovementSummaries do
  use Ecto.Migration

  def change do
    create table(:stock_movement_summaries) do
      add :day, :integer
      add :month, :integer
      add :year, :integer
      add :stock_id, :integer
      add :amount, :integer

      timestamps()
    end

  end
end
