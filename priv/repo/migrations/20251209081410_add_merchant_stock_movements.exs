defmodule CommerceFront.Repo.Migrations.AddMerchantStockMovements do
  use Ecto.Migration

  def change do
    create table(:merchant_stock_movements) do
      add :amount, :integer
      add :remarks, :string
      add :merchant_stock_id, :integer
      add :location_id, :integer
      timestamps()
    end

    create index(:merchant_stock_movements, [:merchant_stock_id])



    create table(:merchant_stock_movement_summaries) do
      add :amount, :integer
      add :day, :integer
      add :month, :integer
      add :year, :integer
      add :merchant_stock_id, :integer
      add :location_id, :integer
      timestamps()
    end

    create index(:merchant_stock_movement_summaries, [:merchant_stock_id])
    create index(:merchant_stock_movement_summaries, [:location_id])



    create table(:merchant_pick_up_points) do
      add :name, :string
      add :desc, :string
      add :address, :string
      add :city, :string
      add :state, :string
      add :zip, :string
      add :country_id, :integer
      timestamps()
    end





  end
end
