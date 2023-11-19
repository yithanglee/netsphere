defmodule CommerceFront.Repo.Migrations.CreateWalletTypes do
  use Ecto.Migration

  def change do
    create table(:wallet_types) do
      add :name, :string
      add :desc, :string
      add :cname, :string

      timestamps()
    end

  end
end
