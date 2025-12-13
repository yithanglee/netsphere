defmodule CommerceFront.Settings.MerchantStockMovementSummary do
  use Ecto.Schema
  import Ecto.Changeset

  schema "merchant_stock_summaries" do
    field(:amount, :integer)
    field(:day, :integer)
    field(:month, :integer)

    belongs_to(:location, CommerceFront.Settings.MerchantPickUpPoint)
    # field(:location_id, :integer)
    # field :merchant_stock_id, :integer
    belongs_to(:merchant_stock, CommerceFront.Settings.MerchantStock)
    field(:year, :integer)

    timestamps()
  end

  @doc false
  def changeset(merchant_stock_summary, attrs) do
    merchant_stock_summary
    |> cast(attrs, [:location_id, :day, :month, :year, :merchant_stock_id, :amount])
    |> validate_required([:day, :month, :year, :merchant_stock_id, :amount])
  end
end
