defmodule CommerceFront.Repo.Migrations.CreateReferralGroupSalesSummaries do
  use Ecto.Migration

  def change do
    create table(:referral_group_sales_summaries) do
      add :month, :integer
      add :year, :integer
      add :user_id, :integer
      add :amount, :float

      timestamps()
    end

  end
end
