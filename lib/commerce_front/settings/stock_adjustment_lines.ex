defmodule CommerceFront.Settings.StockAdjustmentLine do
  use Ecto.Schema
  import Ecto.Changeset

  schema "stock_adjustment_lines" do
    field(:qty, :integer)
    field(:stock_adjustment_id, :integer)
    # field(:stock_id, :integer)
    belongs_to(:stock, CommerceFront.Settings.Stock)
    timestamps()
  end

  @doc false
  def changeset(stock_adjustment_lines, attrs) do
    stock_adjustment_lines
    |> cast(attrs, [:stock_adjustment_id, :stock_id, :qty])
    |> validate_required([:stock_adjustment_id, :stock_id, :qty])
  end
end
