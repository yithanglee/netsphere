defmodule CommerceFront.Repo.Migrations.AddImg234ToMerchantProducts do
  use Ecto.Migration

  def change do
    alter table(:merchant_products) do
      add :img_url2, :string
      add :img_url3, :string
      add :img_url4, :string
    end
  end
end
