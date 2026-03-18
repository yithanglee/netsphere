defmodule CommerceFront.Repo.Migrations.AddTriggerSourceToOrders do
  use Ecto.Migration

  def change do
    alter table(:secondary_market_orders) do
      add :trigger_source, :string
    end

    create index(:secondary_market_orders, [:trigger_source])
  end
end
