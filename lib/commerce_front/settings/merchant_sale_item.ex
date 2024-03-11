defmodule CommerceFront.Settings.MerchantSaleItem do
  use Ecto.Schema
  import Ecto.Changeset

  schema "merchant_sales_items" do
    field(:img_url, :string)
    field(:item_pv, :integer)
    field(:merchant_sales_id, :integer)
    field(:product_name, :string)
    field(:product_price, :float)
    field(:qty, :integer)
    field(:remarks, :string)

    timestamps()
  end

  @doc false
  def changeset(merchant_sale_item, attrs) do
    merchant_sale_item
    |> cast(attrs, [
      :merchant_sales_id,
      :product_name,
      :product_price,
      :qty,
      :remarks,
      :item_pv,
      :img_url
    ])
    |> validate_required([
      :merchant_sales_id,
      :product_name,
      :product_price,
      :qty,
      :remarks,
      :item_pv,
      :img_url
    ])
  end
end
