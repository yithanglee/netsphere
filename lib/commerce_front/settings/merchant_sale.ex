defmodule CommerceFront.Settings.MerchantSale do
  use Ecto.Schema
  import Ecto.Changeset

  schema "merchant_sales" do
    field(:merchant_id, :integer)
    field(:status, :string)
    field(:subtotal, :float)
    field(:total_pv, :float)
    field(:user_id, :integer)
    has_many(:merchant_sales_items, CommerceFront.Settings.MerchantSaleItem)
    timestamps()
  end

  @doc false
  def changeset(merchant_sale, attrs) do
    merchant_sale
    |> cast(attrs, [:user_id, :subtotal, :total_pv, :status, :merchant_id])
    |> validate_required([:user_id, :subtotal, :total_pv, :status, :merchant_id])
  end
end
