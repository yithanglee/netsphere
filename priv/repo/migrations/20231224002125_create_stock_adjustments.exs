defmodule CommerceFront.Repo.Migrations.CreateStockAdjustments do
  use Ecto.Migration

  def change do
    create table(:stock_adjustments) do
      add :day, :integer
      add :month, :integer
      add :year, :integer
      add :description, :binary
      add :title, :string
      add :staff_id, :integer
      add :ref_no, :string

      timestamps()
    end

  end
end
