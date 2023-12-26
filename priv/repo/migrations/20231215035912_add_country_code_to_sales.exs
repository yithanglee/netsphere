defmodule CommerceFront.Repo.Migrations.AddCountryCodeToSales do
  use Ecto.Migration

  def change do
    alter table("sales") do
      add :country_id, :integer
    end
  end
end
