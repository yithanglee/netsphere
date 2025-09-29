defmodule CommerceFront.Repo.Migrations.AddTradedQtyToAssetTranches do
  use Ecto.Migration

  def change do
    alter table(:asset_tranches) do
      add :traded_qty, :decimal, null: false, default: 0
    end


  end
end
