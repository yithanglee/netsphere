defmodule CommerceFront.Repo.Migrations.CreateMerchantProducts do
  use Ecto.Migration

  def change do
    create table(:merchant_products) do
      add :name, :string
      add :retail_price, :float
      add :point_value, :float
      add :img_url, :string
      add :description, :binary
      add :short_desc, :string
      add :merchant_id, :integer
      add :brand_name, :string
      add :category_name, :string

      timestamps()
    end

  end
end
