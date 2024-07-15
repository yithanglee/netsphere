defmodule CommerceFront.Settings.InstalmentProduct do
  use Ecto.Schema
  import Ecto.Changeset

  schema "instalment_products" do
    field(:month_no, :integer)
    # field(:product_id, :integer)
    belongs_to(:product, CommerceFront.Settings.Product)

    field(:qty, :integer, default: 1)
    # field(:instalment_id, references(:instalments))
    belongs_to(:instalment, CommerceFront.Settings.Instalment)
    # field(:instalment_product_id, :integer)
    belongs_to(:instalment_product, CommerceFront.Settings.Product)

    has_many(:member_instalment_product, CommerceFront.Settings.MemberInstalmentProduct,
      on_delete: :delete_all
    )

    timestamps()
  end

  @doc false
  def changeset(instalment_product, attrs) do
    instalment_product
    |> cast(attrs, [
      :instalment_id,
      :instalment_product_id,
      :product_id,
      :qty,
      :month_no
    ])

    # |> validate_required([:product_id, :qty, :month_no])
  end
end
