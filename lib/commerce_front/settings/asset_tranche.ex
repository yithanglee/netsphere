defmodule CommerceFront.Settings.AssetTranche do
  use Ecto.Schema
  import Ecto.Changeset

  schema "asset_tranches" do
    field(:qty_sold, :decimal)
    field(:quantity, :decimal)
    field(:traded_qty, :decimal)
    field(:released_at, :utc_datetime_usec)
    field(:seq, :integer)
    field(:state, :string)
    field(:unit_price, :decimal)
    # field :asset_id, :id
    belongs_to(:asset, CommerceFront.Settings.Asset)

    timestamps()
  end

  @doc false
  def changeset(asset_tranche, attrs) do
    asset_tranche
    |> cast(attrs, [
      :asset_id,
      :seq,
      :quantity,
      :qty_sold,
      :traded_qty,
      :unit_price,
      :state,
      :released_at
    ])
    |> validate_required([:asset_id, :seq, :quantity, :unit_price, :state])
    |> unique_constraint([:asset_id, :seq])
    |> check_constraint(:qty_sold, name: :tranche_not_oversold)
  end
end
