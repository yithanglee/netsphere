defmodule CommerceFront.Settings.Location do
  use Ecto.Schema
  import Ecto.Changeset

  schema "locations" do
    field :country_id, :integer
    field :desc, :string
    field :name, :string
    field :state_id, :integer

    timestamps()
  end

  @doc false
  def changeset(location, attrs) do
    location
    |> cast(attrs, [:name, :desc, :state_id, :country_id])
    |> validate_required([:name, :desc, :state_id, :country_id])
  end
end
