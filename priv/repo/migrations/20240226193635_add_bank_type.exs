defmodule CommerceFront.Repo.Migrations.AddBankType do
  use Ecto.Migration

  def change do
alter table("wallet_topups") do
   add :bank, :string 
end
  end
end
