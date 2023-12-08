defmodule CommerceFront.Repo.Migrations.AddShippingFeeToSale do
  use Ecto.Migration

  def change do
    alter table("sales") do
      add :shipping_fee, :float, default: 0.0
      add :grand_total, :float, default: 0.0
    end
  end
end
