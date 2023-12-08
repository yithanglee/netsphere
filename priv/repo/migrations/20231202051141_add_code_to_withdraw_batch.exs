defmodule CommerceFront.Repo.Migrations.AddCodeToWithdrawBatch do
  use Ecto.Migration

  def change do
    alter table("withdrawal_batches") do
      add :code, :string
    end
  end
end
