defmodule CommerceFront.Repo.Migrations.AddCountryIdToMerchants do
  use Ecto.Migration

  def change do
    alter table("merchants") do
      add :country_id, references(:countries)
    end
  end
end
