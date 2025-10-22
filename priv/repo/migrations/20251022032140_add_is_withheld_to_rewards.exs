defmodule CommerceFront.Repo.Migrations.AddIsWithheldToRewards do
  use Ecto.Migration

  def change do
    alter table(:rewards) do
      add :is_withheld, :boolean, default: false
    end
  end
end
