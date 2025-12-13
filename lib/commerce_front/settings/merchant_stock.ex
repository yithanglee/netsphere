defmodule CommerceFront.Settings.MerchantStock do
  use Ecto.Schema
  import Ecto.Changeset

  schema "merchant_stocks" do
    field(:desc, :string)
    field(:name, :string)

    timestamps()
  end

  @doc false
  def changeset(merchant_stock, attrs) do
    merchant_stock
    |> cast(attrs, [:name, :desc])
    |> validate_required([:name, :desc])
  end
end
