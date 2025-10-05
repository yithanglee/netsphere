defmodule CommerceFront.Repo.Migrations.AddWalletTxRefsToSecondaryMarketTrades do
  use Ecto.Migration

  def change do
    alter table(:secondary_market_trades) do
      add :buyer_token_tx_id, references(:wallet_transactions, on_delete: :nilify_all)
      add :buyer_asset_tx_id, references(:wallet_transactions, on_delete: :nilify_all)
      add :seller_token_tx_id, references(:wallet_transactions, on_delete: :nilify_all)
      add :seller_bonus_tx_id, references(:wallet_transactions, on_delete: :nilify_all)
      add :seller_active_token_tx_id, references(:wallet_transactions, on_delete: :nilify_all)
      add :seller_asset_tx_id, references(:wallet_transactions, on_delete: :nilify_all)
    end

    create index(:secondary_market_trades, [:buyer_token_tx_id])
    create index(:secondary_market_trades, [:buyer_asset_tx_id])
    create index(:secondary_market_trades, [:seller_token_tx_id])
    create index(:secondary_market_trades, [:seller_bonus_tx_id])
    create index(:secondary_market_trades, [:seller_active_token_tx_id])
    create index(:secondary_market_trades, [:seller_asset_tx_id])
  end
end
