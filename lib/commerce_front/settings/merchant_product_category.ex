defmodule CommerceFront.Settings.MerchantProductCategory do
  use Ecto.Schema
  import Ecto.Changeset

  schema "merchant_product_categories" do
    field :desc, :string
    field :icon_name, :string
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(merchant_product_category, attrs) do
    merchant_product_category
    |> cast(attrs, [:name, :desc, :icon_name])
    |> validate_required([:name, :desc, :icon_name])
  end
end
