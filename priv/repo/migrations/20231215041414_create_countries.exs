defmodule CommerceFront.Repo.Migrations.CreateCountries do
  use Ecto.Migration

  def change do
    create table(:countries) do
      add :name, :string
      add :currency, :string
      add :conversion, :float
      add :img_url, :string

      timestamps()
    end

  end
end
