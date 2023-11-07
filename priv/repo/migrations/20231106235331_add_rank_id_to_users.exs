defmodule CommerceFront.Repo.Migrations.AddRankIdToUsers do
  use Ecto.Migration

  def change do
    alter table("users") do
      add :rank_id, references(:ranks)
    end
  end
end
