defmodule CommerceFront.Repo.Migrations.CreateEwalletTransfers do
  use Ecto.Migration

  def change do
    create table(:ewallet_transfers) do
      add :from_username, :string
      add :to_username, :string
      add :from_user_id, :integer
      add :to_user_id, :integer
      add :wallet_type_id, :integer
      add :amount, :string
      add :is_approved, :boolean, default: false, null: false
      add :approved_by, :string
      add :approved_datetime, :naive_datetime
      add :remarks, :string
      add :img_url, :string

      timestamps()
    end

  end
end
