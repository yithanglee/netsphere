defmodule CommerceFront.Repo.Migrations.CreateCryptoWallets do
  use Ecto.Migration

  def change do
    create table(:crypto_wallets) do
      add :user_id, references(:users)
      add :address, :string
      add :private_key, :string
      add :public_key, :string

      timestamps()
    end

  end
end
