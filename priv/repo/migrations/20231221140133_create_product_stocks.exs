defmodule CommerceFront.Repo.Migrations.CreateProductStocks do
  use Ecto.Migration

  def change do
    create table(:product_stocks) do
      add :product_id, :integer
      add :stock_id, :integer
      add :qty, :integer

      timestamps()
    end

  end
end
