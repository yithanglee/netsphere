defmodule CommerceFront.Settings.Trade do
  use Ecto.Schema
  import Ecto.Changeset

  schema "trades" do
    field :fees_amount, :decimal
    field :fees_bps, :integer
    field :price, :decimal
    field :qty, :decimal
    field :side, :string
    field :asset_id, :id
    field :buyer_order_id, :id
    field :seller_order_id, :id
    field :tranche_id, :id

    # timestamps()
    field :inserted_at, :utc_datetime_usec
    # field :updated_at, :utc_datetime_usec
  end

  @doc false
  def changeset(trade, attrs) do
    trade
    |> cast(attrs, [:inserted_at, :asset_id, :buyer_order_id, :seller_order_id, :tranche_id, :side, :price, :qty, :fees_bps, :fees_amount])
    |> validate_required([:inserted_at, :asset_id, :side, :price, :qty])
  end
end
