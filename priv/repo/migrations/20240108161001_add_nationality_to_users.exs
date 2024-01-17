defmodule CommerceFront.Repo.Migrations.AddNationalityToUsers do
  use Ecto.Migration

  def change do
    alter table("users") do
      add :country_id, :integer
    end
  end
end
