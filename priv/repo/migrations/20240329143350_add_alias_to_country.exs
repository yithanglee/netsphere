defmodule CommerceFront.Repo.Migrations.AddAliasToCountry do
  use Ecto.Migration

  def change do
    alter table("countries") do
       add :alias, :string 
    end
  end
end
