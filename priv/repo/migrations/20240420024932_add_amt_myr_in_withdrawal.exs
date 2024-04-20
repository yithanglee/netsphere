defmodule CommerceFront.Repo.Migrations.AddAmtMyrInWithdrawal do
  use Ecto.Migration

  def change do
alter table("wallet_withdrawals") do
   add :amount_in_myr, :float , default: 0.0
   add :final_amount_in_myr, :float , default: 0.0
   add :processing_fee, :float, default: 0.0
   add :processing_fee_in_myr, :float, default: 0.0
end
  end
end
