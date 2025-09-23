defmodule CommerceFront.Settings.SecondaryMarketTrade do
  use Ecto.Schema
  import Ecto.Changeset

  schema "secondary_market_trades" do
    field :quantity, :decimal
    field :price_per_unit, :decimal
    field :total_amount, :decimal
    field :trade_date, :utc_datetime

    belongs_to(:buy_order, CommerceFront.Settings.SecondaryMarketOrder)
    belongs_to(:sell_order, CommerceFront.Settings.SecondaryMarketOrder)
    belongs_to(:buyer, CommerceFront.Settings.User)
    belongs_to(:seller, CommerceFront.Settings.User)
    belongs_to(:asset, CommerceFront.Settings.Asset)

    timestamps()
  end

  @doc false
  def changeset(secondary_market_trade, attrs) do
    secondary_market_trade
    |> cast(attrs, [:buy_order_id, :sell_order_id, :buyer_id, :seller_id, :asset_id, :quantity, :price_per_unit, :total_amount, :trade_date])
    |> validate_required([:buyer_id, :seller_id, :asset_id, :quantity, :price_per_unit, :total_amount, :trade_date])
    |> validate_number(:quantity, greater_than: 0)
    |> validate_number(:price_per_unit, greater_than: 0)
    |> validate_number(:total_amount, greater_than: 0)
  end
end
