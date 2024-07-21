defmodule CommerceFront.Repo.Migrations.AddIsInstalmentAndHasFreebies do
  use Ecto.Migration

  def change do
    alter table("sales") do
      add :is_instalment, :boolean, default: false 
      add :has_freebies, :boolean, default: false
    end
  end
end
