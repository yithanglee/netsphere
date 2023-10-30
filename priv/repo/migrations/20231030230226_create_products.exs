defmodule CommerceFront.Repo.Migrations.CreateProducts do
  use Ecto.Migration

  def change do
    create table(:products) do
      add :img_url, :string
      add :name, :string
      add :cname, :string
      add :category, :string
      add :category_id, :integer
      add :desc, :string
      add :retail_price, :float
      add :point_value, :integer

      timestamps()
    end

  end
end
