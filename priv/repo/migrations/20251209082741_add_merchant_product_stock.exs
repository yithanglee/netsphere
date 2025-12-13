defmodule CommerceFront.Repo.Migrations.AddMerchantProductStock do
  use Ecto.Migration

  def change do

    create table(:merchant_product_stocks) do
      add :merchant_product_id, references(:merchant_products)
      add :merchant_stock_id, references(:merchant_stocks)
      add :qty, :integer
      timestamps()
    end


  end
end
