defmodule CommerceFront.Repo.Migrations.AddActiveQtyToHoldings do
  use Ecto.Migration

  def change do
    alter table(:holdings) do
      add :active_qty, :decimal, null: false, default: 0
    end
  end
end
