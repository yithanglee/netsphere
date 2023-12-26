defmodule CommerceFront.Settings.StockAdjustment do
  use Ecto.Schema
  import Ecto.Changeset

  schema "stock_adjustments" do
    field(:status, :string, default: "pending")
    field(:day, :integer)
    field(:description, :binary)
    field(:month, :integer)
    field(:ref_no, :string)
    field(:staff_id, :integer)
    field(:title, :string)
    field(:year, :integer)

    field(:location_id, :integer)
    has_many(:stock_adjustment_lines, CommerceFront.Settings.StockAdjustmentLine)
    timestamps()
  end

  @doc false
  def changeset(stock_adjustment, attrs) do
    stock_adjustment
    |> cast(attrs, [
      :location_id,
      :status,
      :day,
      :month,
      :year,
      :description,
      :title,
      :staff_id,
      :ref_no
    ])
    |> validate_required([:day, :month, :year, :title, :staff_id, :ref_no])
  end
end
