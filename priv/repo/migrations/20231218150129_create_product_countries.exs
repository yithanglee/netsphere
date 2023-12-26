defmodule CommerceFront.Repo.Migrations.CreateProductCountries do
  use Ecto.Migration

  def change do
    create table(:product_countries) do
      add :product_id, :integer
      add :country_id, :integer

      timestamps()
    end

  end
end
