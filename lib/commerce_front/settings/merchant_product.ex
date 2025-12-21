defmodule CommerceFront.Settings.MerchantProduct do
  use Ecto.Schema
  import Ecto.Changeset
  import EctoEnum

  defenum(
    ProductConditionEnum,
    ~w(
      new
      like_new
      used
    )
  )

  schema "merchant_products" do
    field(:brand_name, :string)
    belongs_to(:merchant_product_category, CommerceFront.Settings.MerchantProductCategory)
    # Backwards-compat: legacy free-text category name (kept for older clients)
    field(:category_name, :string)
    field(:description, :binary)
    field(:img_url, :string)
    field(:img_url2, :string)
    field(:img_url3, :string)
    field(:img_url4, :string)
    belongs_to(:merchant, CommerceFront.Settings.Merchant)
    # field :merchant_id, :integer
    field(:name, :string)
    field(:point_value, :float)
    field(:retail_price, :float)
    field(:short_desc, :string)
    field(:override_pv, :boolean, virtual: true)

    has_many(:merchant_product_stock, CommerceFront.Settings.MerchantProductStock)

    has_many(:merchant_stocks, through: [:merchant_product_stock, :merchant_stock])

    field(:product_condition, ProductConditionEnum, default: :new)
    timestamps()
  end
  @doc false
  def changeset(merchant_product, attrs) do
    merchant_product |> cast(attrs, [
      :img_url2,
      :img_url3,
      :img_url4,
      :name,
      :retail_price,
      :point_value,
      :img_url,
      :description,
      :short_desc,
      :merchant_id,
      :brand_name,
      :category_name,
      :merchant_product_category_id,
      :product_condition
    ])
    |> validate_required([
      :name,
      :retail_price,
      # :point_value,
      # :img_url,
      :description,
      :merchant_id,
      :merchant_product_category_id
    ])
  end
end
