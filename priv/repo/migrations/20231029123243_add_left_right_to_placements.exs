defmodule CommerceFront.Repo.Migrations.AddLeftRightToPlacements do
  use Ecto.Migration

  def change do
    alter table("placements") do
       add :left, :integer , default: 0
       add :right, :integer , default: 0
    end
  end
end
