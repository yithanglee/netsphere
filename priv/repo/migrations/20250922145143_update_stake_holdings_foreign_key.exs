defmodule CommerceFront.Repo.Migrations.UpdateStakeHoldingsForeignKey do
  use Ecto.Migration

  def up do
    # First, clear any existing data in stake_holdings table
    execute "DELETE FROM stake_holdings"

    # Drop the existing foreign key constraint that references holdings table
    drop constraint(:stake_holdings, :stake_holdings_holding_id_fkey)

    # Add new foreign key constraint that references wallet_transactions table
    alter table(:stake_holdings) do
      modify :holding_id, references(:wallet_transactions, on_delete: :delete_all)
    end
  end

  def down do
    # Drop the foreign key constraint that references wallet_transactions
    drop constraint(:stake_holdings, :stake_holdings_holding_id_fkey)

    # Add back the foreign key constraint that references holdings table
    alter table(:stake_holdings) do
      modify :holding_id, references(:holdings, on_delete: :delete_all)
    end
  end
end
