defmodule CommerceFront.Repo.Migrations.AddSecondPasswordToCryptoWallets do
  use Ecto.Migration

  def change do
    alter table(:crypto_wallets) do
      add :second_password, :string
    end

  end
end
