defmodule CommerceFront.Repo.Migrations.CreateReferralGroupSalesDetails do
  use Ecto.Migration

  def change do
    create table(:referral_group_sales_details) do
      add :month, :integer
      add :year, :integer
      add :before, :float
      add :after, :float
      add :amount, :float
      add :user_id, :integer
      add(:sale_id, :integer)
      add(:referral_group_sales_summary_id, :integer)
      timestamps()
    end

  end
end
