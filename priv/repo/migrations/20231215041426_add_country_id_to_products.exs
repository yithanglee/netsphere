defmodule CommerceFront.Repo.Migrations.AddCountryIdToProducts do
  use Ecto.Migration

  def change do
    alter table("products") do
      add :country_id, :integer
    end
  end
end
