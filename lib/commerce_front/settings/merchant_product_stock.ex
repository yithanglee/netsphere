defmodule CommerceFront.Settings.MerchantProductStock do
  use Ecto.Schema
  import Ecto.Changeset

  schema "merchant_product_stocks" do
    # field(:merchant_product_id, :integer)
    belongs_to(:merchant_product, CommerceFront.Settings.MerchantProduct)
    field(:qty, :integer)
    # field(:merchant_stock_id, :integer)
    belongs_to(:merchant_stock, CommerceFront.Settings.MerchantStock)
    timestamps()
  end

  @doc false
  def changeset(merchant_product_stock, attrs) do
    merchant_product_stock
    |> cast(attrs, [:merchant_product_id, :merchant_stock_id, :qty])
    |> validate_required([:merchant_product_id, :merchant_stock_id])
  end
end
