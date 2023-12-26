defmodule CommerceFront.Settings.ProductCountry do
  use Ecto.Schema
  import Ecto.Changeset

  schema "product_countries" do
    belongs_to(:country, CommerceFront.Settings.Country)
    belongs_to(:product, CommerceFront.Settings.Product)

    # field :country_id, :integer
    # field :product_id, :integer

    timestamps()
  end

  @doc false
  def changeset(product_country, attrs) do
    product_country
    |> cast(attrs, [:product_id, :country_id])
    |> validate_required([:product_id, :country_id])
  end
end
