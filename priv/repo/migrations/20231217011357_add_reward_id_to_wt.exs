defmodule CommerceFront.Repo.Migrations.AddRewardIdToWt do
  use Ecto.Migration

  def change do
    alter table("wallet_transactions") do
      add :reward_id, :integer
    end
  end
end
