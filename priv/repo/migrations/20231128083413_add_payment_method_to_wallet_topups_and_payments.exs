defmodule CommerceFront.Repo.Migrations.AddPaymentMethodToWalletTopupsAndPayments do
  use Ecto.Migration

  def change do
    alter table("wallet_topups") do
      add :payment_method, :string, default: "fpx"
    end
    alter table("payments") do
      add :payment_method, :string, default: "fpx"
    end
  end
end
