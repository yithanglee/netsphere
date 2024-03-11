defmodule CommerceFront.Repo.Migrations.AddCountryIdToStaffs do
  use Ecto.Migration

  def change do
alter table("staffs") do 
  add :country_id, references(:countries)
end 
  end
end
