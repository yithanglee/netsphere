defmodule CommerceFront.Repo.Migrations.CreateGroupSalesSummaries do
  use Ecto.Migration

  def change do
    create table(:group_sales_summaries) do
      add :user_id, :integer
      add :day, :integer
      add :month, :integer
      add :year, :integer
      add :balance_left, :integer
      add :balance_right, :integer
      add :total_left, :integer
      add :total_right, :integer
      add :paired, :integer

      timestamps()
    end

  end
end
