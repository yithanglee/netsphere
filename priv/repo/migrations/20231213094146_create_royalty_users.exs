defmodule CommerceFront.Repo.Migrations.CreateRoyaltyUsers do
  use Ecto.Migration

  def change do
    create table(:royalty_users) do
      add :user_id, :integer
      add :perc, :float

      timestamps()
    end

  end
end
