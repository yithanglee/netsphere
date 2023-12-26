defmodule CommerceFront.Repo.Migrations.CreateStates do
  use Ecto.Migration

  def change do
    create table(:states) do
      add :name, :string
      add :country_id, :integer
      add :shortcode, :string

      timestamps()
    end

  end
end
