defmodule CommerceFront.Repo.Migrations.CreateReferrals do
  use Ecto.Migration

  def change do
    create table(:referrals) do
      add :user_id, :integer
      add :parent_user_id, :integer
      add :parent_referral_id, :integer

      timestamps()
    end

  end
end
