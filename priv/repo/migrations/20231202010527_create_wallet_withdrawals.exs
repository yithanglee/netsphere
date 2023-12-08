defmodule CommerceFront.Repo.Migrations.CreateWalletWithdrawals do
  use Ecto.Migration

  def change do
    create table(:wallet_withdrawals) do
      add :user_id, :integer
      add :amount, :float
      add :remarks, :string
      add :is_paid, :boolean, default: false, null: false
      add :withdrawal_batch_id, :integer
      add :paid_date, :date
      add :bank_name, :string
      add :bank_account_number, :string

      timestamps()
    end

  end
end
