defmodule CommerceFront.Settings.ProductStock do
  use Ecto.Schema
  import Ecto.Changeset

  schema "product_stocks" do
    # field(:product_id, :integer)
    belongs_to(:product, CommerceFront.Settings.Product)
    field(:qty, :integer)
    # field(:stock_id, :integer)
    belongs_to(:stock, CommerceFront.Settings.Stock)
    timestamps()
  end

  @doc false
  def changeset(product_stock, attrs) do
    product_stock
    |> cast(attrs, [:product_id, :stock_id, :qty])
    |> validate_required([:product_id, :stock_id])
  end
end
