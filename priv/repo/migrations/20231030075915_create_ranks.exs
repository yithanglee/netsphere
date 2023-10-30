defmodule CommerceFront.Repo.Migrations.CreateRanks do
  use Ecto.Migration

  def change do
    create table(:ranks) do
      add :name, :string
      add :retail_price, :float
      add :register_point, :integer
      add :point_value, :integer
      add :img_url, :string
      add :desc, :binary

      timestamps()
    end

  end
end
