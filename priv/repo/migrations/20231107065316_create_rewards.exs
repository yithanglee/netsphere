defmodule CommerceFront.Repo.Migrations.CreateRewards do
  use Ecto.Migration

  def change do
    create table(:rewards) do
      add :is_paid, :boolean, default: false, null: false
      add :remarks, :binary
      add :user_id, :integer
      add :amount, :float
      add :day, :integer
      add :month, :integer
      add :year, :integer
      add :sales_id, :integer
      add :name, :string

      timestamps()
    end

  end
end
