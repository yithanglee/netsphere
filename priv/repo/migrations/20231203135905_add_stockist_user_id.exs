defmodule CommerceFront.Repo.Migrations.AddStockistUserId do
  use Ecto.Migration

  def change do
    alter table("users") do
       add :stockist_user_id, references(:users)
    end
  end
end
