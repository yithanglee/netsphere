defmodule CommerceFront.Repo.Migrations.CreateSwapBacks do
  use Ecto.Migration

  def change do
    create table(:swap_backs) do
      add :user_id, references(:users)
      add :user_wallet_address, :string
      add :treasury_address, :string
      add :amount_raw, :integer
      add :amount, :decimal
      add :tx_hash, :string
      add :status, :string, default: "pending"
      add :reason, :string
      add :staff_id, references(:staffs)
      add :approved_at, :naive_datetime
      add :rate_used, :string
      add :points_credited, :decimal

      timestamps()
    end

  end
end
