defmodule CommerceFront.Repo.Migrations.CreateMerchantSales do
  use Ecto.Migration

  def change do
    create table(:merchant_sales) do
      add :user_id, :integer
      add :subtotal, :float
      add :total_pv, :float
      add :status, :string
      add :merchant_id, :integer

      timestamps()
    end

  end
end
