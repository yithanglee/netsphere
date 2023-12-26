defmodule CommerceFront.Repo.Migrations.AddLocationIdToStockAdjustment do
  use Ecto.Migration

  def change do
    alter table("stock_adjustments") do
       add :location_id, :integer
    end
  end
end
