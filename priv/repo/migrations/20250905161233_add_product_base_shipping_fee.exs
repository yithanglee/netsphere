defmodule CommerceFront.Repo.Migrations.AddProductBaseShippingFee do
  use Ecto.Migration

  def change do
    alter table("products") do
      add :base_shipping_fee, :float, default: 0.0
    end
  end
end
