defmodule CommerceFront.Repo.Migrations.AddWalletTopupIdToPayments do
  use Ecto.Migration

  def change do
    alter table("payments") do
      add :wallet_topup_id, references(:wallet_topups)
    end
  end
end
