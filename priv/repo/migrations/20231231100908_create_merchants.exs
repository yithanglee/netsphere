defmodule CommerceFront.Repo.Migrations.CreateMerchants do
  use Ecto.Migration

  def change do
    create table(:merchants) do
      add :name, :string
      add :remarks, :string
      add :is_approved, :boolean, default: false, null: false
      add :user_id, :integer

      timestamps()
    end

  end
end
