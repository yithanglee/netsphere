defmodule CommerceFront.Settings.State do
  use Ecto.Schema
  import Ecto.Changeset

  schema "states" do
    belongs_to(:country, CommerceFront.Settings.Country)
    # field :country_id, :integer
    field(:name, :string)
    field(:shortcode, :string)

    timestamps()
  end

  @doc false
  def changeset(state, attrs) do
    state
    |> cast(attrs, [:name, :country_id, :shortcode])

    # |> validate_required([:name, :country_id, :shortcode])
  end
end
