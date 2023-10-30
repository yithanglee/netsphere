defmodule CommerceFront.Repo.Migrations.CreateSales do
  use Ecto.Migration

  def change do
    create table(:sales) do
      add :sale_date, :date
      add :month, :integer
      add :year, :integer
      add :subtotal, :float
      add :user_id, :integer
      add :status, :string
      add :total_point_value, :integer
      add :remarks, :string

      timestamps()
    end

  end
end
