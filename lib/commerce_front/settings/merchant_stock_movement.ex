defmodule CommerceFront.Settings.MerchantStockMovement do
  use Ecto.Schema
  import Ecto.Changeset

  schema "merchant_stock_movements" do
    field(:after, :integer)
    field(:amount, :integer)
    field(:before, :integer)
    field(:location_id, :integer)
    field(:remarks, :string)
    field(:sales_id, :integer)
    field(:staff_id, :integer)
    field(:stock_adjustment_id, :integer)
    # field(:merchant_stock_id, :integer)
    belongs_to(:merchant_stock, CommerceFront.Settings.MerchantStock)
    timestamps()
  end

  @doc false
  def changeset(merchant_stock_movement, attrs) do
    merchant_stock_movement
    |> cast(attrs, [
      :merchant_stock_id,
      :before,
      :after,
      :amount,
      :location_id,
      :sales_id,
      :remarks,
      :stock_adjustment_id,
      :staff_id
    ])

    # |> validate_required([:merchant_stock_id, :before, :after, :amount, :location_id, :sales_id, :remarks, :stock_adjustment_id, :staff_id])
  end
end
