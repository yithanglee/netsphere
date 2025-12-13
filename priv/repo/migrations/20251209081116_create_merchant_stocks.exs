defmodule CommerceFront.Repo.Migrations.CreateMerchantStocks do
  use Ecto.Migration

  def change do
    create table(:merchant_stocks) do
      add :name, :string
      add :desc, :string

      timestamps()
    end

  end
end
