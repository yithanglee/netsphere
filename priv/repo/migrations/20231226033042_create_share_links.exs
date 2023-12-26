defmodule CommerceFront.Repo.Migrations.CreateShareLinks do
  use Ecto.Migration

  def change do
    create table(:share_links) do
      add :user_id, :integer
      add :share_code, :string
      add :position, :string

      timestamps()
    end

  end
end
