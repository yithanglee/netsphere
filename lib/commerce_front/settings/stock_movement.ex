defmodule CommerceFront.Settings.StockMovement do
  use Ecto.Schema
  import Ecto.Changeset

  schema "stock_movements" do
    field(:after, :integer)
    field(:amount, :integer)
    field(:before, :integer)
    field(:location_id, :integer)
    field(:remarks, :string)
    field(:sales_id, :integer)
    field(:staff_id, :integer)
    field(:stock_adjustment_id, :integer)
    # field(:stock_id, :integer)
    belongs_to(:stock, CommerceFront.Settings.Stock)
    timestamps()
  end

  @doc false
  def changeset(stock_movement, attrs) do
    stock_movement
    |> cast(attrs, [
      :stock_id,
      :before,
      :after,
      :amount,
      :location_id,
      :sales_id,
      :remarks,
      :stock_adjustment_id,
      :staff_id
    ])

    # |> validate_required([:stock_id, :before, :after, :amount, :location_id, :sales_id, :remarks, :stock_adjustment_id, :staff_id])
  end
end
