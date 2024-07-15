defmodule CommerceFront.Settings.MemberInstalmentProduct do
  use Ecto.Schema
  import Ecto.Changeset

  schema "member_instalment_products" do
    # field(:instalment_product_id, :integer)
    field(:member_instalment_id, :integer)
    belongs_to(:instalment_product, CommerceFront.Settings.InstalmentProduct)
    has_one(:product, through: [:instalment_product, :product])
    timestamps()
  end

  @doc false
  def changeset(member_instalment_product, attrs) do
    member_instalment_product
    |> cast(attrs, [:member_instalment_id, :instalment_product_id])
    |> validate_required([:member_instalment_id, :instalment_product_id])
  end
end
