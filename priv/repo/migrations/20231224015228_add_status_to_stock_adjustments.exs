defmodule CommerceFront.Repo.Migrations.AddStatusToStockAdjustments do
  use Ecto.Migration

  def change do
    alter table("stock_adjustments") do
       add :status, :string, default: "pending"
    end
  end
end
