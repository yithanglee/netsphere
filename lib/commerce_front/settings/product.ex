defmodule CommerceFront.Settings.Product do
  use Ecto.Schema
  import Ecto.Changeset

  schema "products" do
    field(:category, :string)
    field(:category_id, :integer)
    field(:cname, :string)
    field(:desc, :string)
    field(:img_url, :string)
    field(:name, :string)
    field(:point_value, :integer)
    field(:retail_price, :float)

    timestamps()
  end

  @doc false
  def changeset(product, attrs) do
    product
    |> cast(attrs, [
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
