defmodule CommerceFront.Repo.Migrations.CreateMerchantWithdrawals do
  use Ecto.Migration

  def change do
    create table(:merchant_withdrawals) do
      add :amount, :float
      add :bank_account_number, :string
      add :bank_name, :string
      add :is_paid, :boolean, default: false, null: false
      add :paid_date, :date
      add :remarks, :string
      add :merchant_id, :integer

      timestamps()
    end

  end
end
