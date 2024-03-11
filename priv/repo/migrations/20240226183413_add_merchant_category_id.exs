defmodule CommerceFront.Repo.Migrations.AddMerchantCategoryId do
  use Ecto.Migration

  def change do
    alter table("merchants") do
       add :merchant_category_id, references(:merchant_categories)
    end
  end
end
