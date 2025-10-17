defmodule CommerceFront.Repo.Migrations.AddTxHash do
  use Ecto.Migration

  def change do
    alter table("wallet_withdrawals") do
      add :tx_hash, :string
    end
  end
end
