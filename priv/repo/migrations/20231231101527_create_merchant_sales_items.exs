defmodule CommerceFront.Repo.Migrations.CreateMerchantSalesItems do
  use Ecto.Migration

  def change do
    create table(:merchant_sales_items) do
      add :merchant_sales_id, :integer
      add :product_name, :string
      add :product_price, :float
      add :qty, :integer
      add :remarks, :string
      add :item_pv, :integer
      add :img_url, :string

      timestamps()
    end

  end
end
