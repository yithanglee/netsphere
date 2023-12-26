defmodule CommerceFront.Repo.Migrations.AddLocationIdToStockSummary do
  use Ecto.Migration

  def change do
    alter table("stock_movement_summaries") do 
      add :location_id, :integer 
    end
  end
end
