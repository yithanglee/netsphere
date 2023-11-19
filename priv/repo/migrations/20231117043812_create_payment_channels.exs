defmodule CommerceFront.Repo.Migrations.CreatePaymentChannels do
  use Ecto.Migration

  def change do
    create table(:payment_channels) do
      add :category, :string
      add :active, :boolean, default: false, null: false
      add :code, :string

      timestamps()
    end

  end
end
