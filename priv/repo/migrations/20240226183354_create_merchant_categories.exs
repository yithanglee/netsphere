defmodule CommerceFront.Repo.Migrations.CreateMerchantCategories do
  use Ecto.Migration

  def change do
    create table(:merchant_categories) do
      add :name, :string
      add :desc, :string

      timestamps()
    end

  end
end
