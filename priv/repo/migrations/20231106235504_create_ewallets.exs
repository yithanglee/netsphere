defmodule CommerceFront.Repo.Migrations.CreateEwallets do
  use Ecto.Migration

  def change do
    create table(:ewallets) do
      add :user_id, :integer
      add :wallet_type, :string
      add :total, :float

      timestamps()
    end

  end
end
