defmodule CommerceFront.Repo.Migrations.AddProductConditionToMerchantProducts do
  use Ecto.Migration

  def change do
    alter table(:merchant_products) do
      add :product_condition, :string
    end
  end
end
