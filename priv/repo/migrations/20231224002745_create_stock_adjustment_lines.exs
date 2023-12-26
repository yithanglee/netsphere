defmodule CommerceFront.Repo.Migrations.CreateStockAdjustmentLines do
  use Ecto.Migration

  def change do
    create table(:stock_adjustment_lines) do
      add :stock_adjustment_id, :integer
      add :stock_id, :integer
      add :qty, :integer

      timestamps()
    end

  end
end
