defmodule CommerceFront.Settings.MerchantProduct do
  use Ecto.Schema
  import Ecto.Changeset

  schema "merchant_products" do
    field(:brand_name, :string)
    field(:category_name, :string)
    field(:description, :binary)
    field(:img_url, :string)
    belongs_to(:merchant, CommerceFront.Settings.Merchant)
    # field :merchant_id, :integer
    field(:name, :string)
    field(:point_value, :float)
    field(:retail_price, :float)
    field(:short_desc, :string)

    field(:commission_perc, :float, default: 0.1)
    timestamps()
  end

  @doc false
  def changeset(merchant_product, attrs) do
    merchant_product
    |> cast(attrs, [
      :commission_perc,
      :name,
      :retail_price,
      :point_value,
      :img_url,
      :description,
      :short_desc,
      :merchant_id,
      :brand_name,
      :category_name
    ])
    |> validate_required([
      :name,
      :retail_price,
      :point_value,
      # :img_url,
      :description,
      :short_desc,
      :merchant_id,
      :brand_name,
      :category_name
    ])
  end
end
