defmodule CommerceFront.Repo.Migrations.CreateStockMovements do
  use Ecto.Migration

  def change do
    create table(:stock_movements) do
      add :stock_id, :integer
      add :before, :integer
      add :after, :integer
      add :amount, :integer
      add :location_id, :integer
      add :sales_id, :integer
      add :remarks, :string
      add :stock_adjustment_id, :integer
      add :staff_id, :integer

      timestamps()
    end

  end
end
