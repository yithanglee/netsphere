defmodule CommerceFront.Repo.Migrations.CreatePlacements do
  use Ecto.Migration

  def change do
    create table(:placements) do
      add :parent_user_id, :integer
      add :parent_placement_id, :integer
      add :user_id, :integer
      add :position, :string

      timestamps()
    end

  end
end
