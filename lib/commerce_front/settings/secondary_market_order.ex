defmodule CommerceFront.Settings.SecondaryMarketOrder do
  use Ecto.Schema
  import Ecto.Changeset

  schema "secondary_market_orders" do
    field(:order_type, :string)
    field(:quantity, :decimal)
    field(:price_per_unit, :decimal)
    field(:total_amount, :decimal)
    field(:status, :string)
    field(:filled_quantity, :decimal)
    field(:remaining_quantity, :decimal)

    belongs_to(:user, CommerceFront.Settings.User)
    belongs_to(:asset, CommerceFront.Settings.Asset)

    has_many(:buy_trades, CommerceFront.Settings.SecondaryMarketTrade, foreign_key: :buy_order_id)

    has_many(:sell_trades, CommerceFront.Settings.SecondaryMarketTrade,
      foreign_key: :sell_order_id
    )

    timestamps()
  end

  @doc false
  def changeset(secondary_market_order, attrs) do
    secondary_market_order
    |> cast(attrs, [
      :user_id,
      :order_type,
      :asset_id,
      :quantity,
      :price_per_unit,
      :total_amount,
      :status,
      :filled_quantity,
      :remaining_quantity
    ])
    |> validate_required([
      :user_id,
      :order_type,
      :asset_id,
      :quantity,
      :price_per_unit,
      :total_amount,
      :status,
      :remaining_quantity
    ])
    |> validate_inclusion(:order_type, ["buy", "sell"])
    |> validate_inclusion(:status, ["pending", "filled", "cancelled"])
    |> validate_number(:quantity, greater_than: 0)
    |> validate_number(:price_per_unit, greater_than: 0)
    |> validate_number(:total_amount, greater_than: 0)
    |> validate_number(:filled_quantity, greater_than_or_equal_to: 0)
    |> validate_number(:remaining_quantity, greater_than_or_equal_to: 0)
  end

  def create_changeset(attrs) do
    %__MODULE__{}
    |> changeset(attrs)
    |> validate_total_amount()
  end

  defp validate_total_amount(changeset) do
    quantity = get_field(changeset, :quantity)
    price_per_unit = get_field(changeset, :price_per_unit)
    total_amount = get_field(changeset, :total_amount)

    if quantity && price_per_unit && total_amount do
      expected_total = Decimal.mult(quantity, price_per_unit)

      if Decimal.compare(total_amount, expected_total) == :eq do
        changeset
      else
        add_error(changeset, :total_amount, "must equal quantity × price_per_unit")
      end
    else
      changeset
    end
  end
end
