defmodule CommerceFront.Settings.Asset do
  use Ecto.Schema
  import Ecto.Changeset

  schema "assets" do
    field(:base_price, :decimal)
    field(:decimals, :integer)
    field(:min_order_qty, :decimal)
    field(:name, :string)
    field(:price_increment_type, :string)
    field(:price_increment_value, :decimal)
    field(:status, :string)
    field(:symbol, :string)
    field(:total_supply_cap, :decimal)

    timestamps()
  end

  @doc false
  def changeset(asset, attrs) do
    asset
    |> cast(attrs, [
      :symbol,
      :name,
      :decimals,
      :base_price,
      :price_increment_type,
      :price_increment_value,
      :min_order_qty,
      :status,
      :total_supply_cap
    ])

    # |> validate_required([:symbol, :name, :decimals, :base_price, :price_increment_type, :price_increment_value, :min_order_qty, :status, :total_supply_cap])
  end
end
