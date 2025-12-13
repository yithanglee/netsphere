defmodule CommerceFront.Settings.MerchantPickUpPoint do
  use Ecto.Schema
  import Ecto.Changeset

  schema "merchant_pick_up_points" do
    field(:address, :string)
    belongs_to(:country, CommerceFront.Settings.Country)
    # field(:country_id, :integer)
    field(:name, :string)
    field(:phone, :string)
    belongs_to(:merchant, CommerceFront.Settings.Merchant)

    belongs_to(:state, CommerceFront.Settings.State)
    # field(:state_id, :integer)

    timestamps()
  end

  @doc false
  def changeset(merchant_pick_up_point, attrs) do
    merchant_pick_up_point
    |> cast(attrs, [:name, :country_id, :state_id, :address, :phone, :merchant_id])

    # |> validate_required([:name, :country_id, :state_id, :address, :phone])
  end
end
