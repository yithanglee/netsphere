defmodule CommerceFront.Repo.Migrations.AddPreferredPositionToUsers do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :preferred_position, :string, default: "left"
    end
  end
end
