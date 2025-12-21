defmodule CommerceFront.Repo.Migrations.CreateMerchantProductCategories do
  use Ecto.Migration

  def change do
    create table(:merchant_product_categories) do
      add :name, :string
      add :desc, :string
      add :icon_name, :string

      timestamps()
    end



    alter table(:merchant_products) do
      add :merchant_product_category_id, references(:merchant_product_categories)
    end



  end
end
