defmodule CommerceFront.Repo.Migrations.AddDelayToInstalment do
  use Ecto.Migration

  def change do
    alter table("instalments") do
      add :delay, :integer, default: 0
    end
  end
end
