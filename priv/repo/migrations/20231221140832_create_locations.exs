defmodule CommerceFront.Repo.Migrations.CreateLocations do
  use Ecto.Migration

  def change do
    create table(:locations) do
      add :name, :string
      add :desc, :string
      add :state_id, :integer
      add :country_id, :integer

      timestamps()
    end

  end
end
