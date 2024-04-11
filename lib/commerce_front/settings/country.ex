defmodule CommerceFront.Settings.Country do
  use Ecto.Schema
  import Ecto.Changeset

  schema "countries" do
    field(:conversion, :float)
    field(:currency, :string)
    field(:img_url, :string)
    field(:name, :string)
    field(:alias, :string)

    timestamps()
  end

  @doc false
  def changeset(country, attrs) do
    country
    |> cast(attrs, [:alias, :name, :currency, :conversion, :img_url])

    # |> validate_required([:name, :currency, :conversion, :img_url])
  end
end
