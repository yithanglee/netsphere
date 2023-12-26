defmodule CommerceFront.Settings.StockMovementSummary do
  use Ecto.Schema
  import Ecto.Changeset

  schema "stock_movement_summaries" do
    field(:amount, :integer)
    field(:day, :integer)
    field(:month, :integer)

    belongs_to(:location, CommerceFront.Settings.PickUpPoint)
    # field(:location_id, :integer)
    # field :stock_id, :integer
    belongs_to(:stock, CommerceFront.Settings.Stock)
    field(:year, :integer)

    timestamps()
  end

  @doc false
  def changeset(stock_movement_summary, attrs) do
    stock_movement_summary
    |> cast(attrs, [:location_id, :day, :month, :year, :stock_id, :amount])
    |> validate_required([:day, :month, :year, :stock_id, :amount])
  end
end
