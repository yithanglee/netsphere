defmodule CommerceFront.Repo.Migrations.AddGsSummaryId do
  use Ecto.Migration

  def change do
    alter table("placement_group_sales_details") do
      add :gs_summary_id, :integer
    end
  end
end
