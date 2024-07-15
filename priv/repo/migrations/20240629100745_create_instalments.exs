defmodule CommerceFront.Repo.Migrations.CreateInstalments do
  use Ecto.Migration

  def change do
    create table(:instalments) do
      add :name, :string
      add :no_of_months, :integer

      timestamps()
    end

  end
end
