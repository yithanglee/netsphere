defmodule CommerceFront.Settings.PickUpPoint do
  use Ecto.Schema
  import Ecto.Changeset

  schema "pick_up_points" do
    field(:address, :string)
    belongs_to(:country, CommerceFront.Settings.Country)
    # field(:country_id, :integer)
    field(:name, :string)
    field(:phone, :string)

    belongs_to(:state, CommerceFront.Settings.State)
    # field(:state_id, :integer)

    timestamps()
  end

  @doc false
  def changeset(pick_up_point, attrs) do
    pick_up_point
    |> cast(attrs, [:name, :country_id, :state_id, :address, :phone])

    # |> validate_required([:name, :country_id, :state_id, :address, :phone])
  end
end
