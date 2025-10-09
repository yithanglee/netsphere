defmodule CommerceFront.Repo.Migrations.AddBeforeAfterToSecondaryMarketTrades do
  use Ecto.Migration

  def change do
    alter table(:secondary_market_trades) do
      add :before, :decimal, default: 0, null: false
      add :after, :decimal, default: 0, null: false
    end

  end
end
