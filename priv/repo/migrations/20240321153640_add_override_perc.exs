defmodule CommerceFront.Repo.Migrations.AddOverridePerc do
  use Ecto.Migration

  def change do
    alter table("products") do
       add :override_perc, :float, default: 0.5
    end
  end
end
