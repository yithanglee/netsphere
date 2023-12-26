defmodule CommerceFront.Repo.Migrations.CreatePickUpPoints do
  use Ecto.Migration

  def change do
    create table(:pick_up_points) do
      add :name, :string
      add :country_id, :integer
      add :state_id, :integer
      add :address, :string
      add :phone, :string

      timestamps()
    end

    alter table("sales") do
      add :pick_up_point_id, :integer
    end
  end
end
