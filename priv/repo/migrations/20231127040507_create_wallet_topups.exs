defmodule CommerceFront.Repo.Migrations.CreateWalletTopups do
  use Ecto.Migration

  def change do
    create table(:wallet_topups) do
      add :user_id, :integer
      add :amount, :float
      add :remarks, :string
      add :is_approved, :boolean, default: false, null: false
      add :img_url, :string

      timestamps()
    end

  end
end
