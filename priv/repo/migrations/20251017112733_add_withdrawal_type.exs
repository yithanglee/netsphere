defmodule CommerceFront.Repo.Migrations.AddWithdrawalType do
  use Ecto.Migration

  def change do
    alter table(:wallet_withdrawals) do
      add :withdrawal_type, :string, default: "bonus"
    end
  end
end
