defmodule CommerceFront.Settings.MerchantCategory do
  use Ecto.Schema
  import Ecto.Changeset

  schema "merchant_categories" do
    field(:desc, :string)
    field(:name, :string)

    timestamps()
  end

  @doc false
  def changeset(merchant_category, attrs) do
    merchant_category
    |> cast(attrs, [:name, :desc])
    |> validate_required([:name])
  end
end
