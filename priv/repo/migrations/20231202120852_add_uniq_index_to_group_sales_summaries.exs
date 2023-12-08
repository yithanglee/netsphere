defmodule CommerceFront.Repo.Migrations.AddUniqIndexToGroupSalesSummaries do
  use Ecto.Migration

  def change do
    create unique_index(:group_sales_summaries, [:day, :month, :year, :user_id])
  end
end
