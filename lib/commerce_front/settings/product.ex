defmodule CommerceFront.Settings.Product do
  use Ecto.Schema
  import Ecto.Changeset

  schema "products" do
    field(:qty, :integer, virtual: true)
    field(:category, :string)
    field(:category_id, :integer)
    field(:cname, :string)
    field(:desc, :binary)
    field(:img_url, :string)
    field(:name, :string)
    field(:point_value, :integer)
    field(:retail_price, :float)
    # field(:country_id, :integer)

    field(:override_pv_amount, :integer)

    field(:override_pv, :boolean, default: false)
    field(:override_perc, :float, default: 0.5)
    field(:override_special_share_payout, :boolean, default: false)
    field(:override_special_share_payout_perc, :float, default: 0.5)

    has_many(:product_stock, CommerceFront.Settings.ProductStock)

    has_many(:stocks, through: [:product_stock, :stock])
    has_many(:product_country, CommerceFront.Settings.ProductCountry)

    has_many(:countries, through: [:product_country, :country])

    timestamps()
  end

  @doc false
  def changeset(product, attrs) do
    product
    |> cast(attrs, [
      :override_perc,
      :override_pv,
      :override_pv_amount,
      :override_special_share_payout_perc,
      :override_special_share_payout,
      :img_url,
      :name,
      :cname,
      :category,
      :category_id,
      :desc,
      :retail_price,
      :point_value
    ])

    # |> validate_required([
    #   :img_url,
    #   :name,
    #   :cname,
    #   :category,
    #   :category_id,
    #   :desc,
    #   :retail_price,
    #   :point_value
    # ])
  end
end
