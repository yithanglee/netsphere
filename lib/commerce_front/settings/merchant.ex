defmodule CommerceFront.Settings.Merchant do
  use Ecto.Schema
  import Ecto.Changeset

  schema "merchants" do
    field(:is_approved, :boolean, default: false)
    field(:name, :string)
    field(:remarks, :string)
    # field(:user_id, :integer)
    belongs_to(:user, CommerceFront.Settings.User)
    has_many(:merchant_products, CommerceFront.Settings.MerchantProduct)
    field(:description, :binary)
    field(:img_url, :string)
    field(:bank_name, :string)
    field(:bank_account_holder, :string)
    field(:bank_account_no, :string)
    timestamps()
  end

  @doc false
  def changeset(merchant, attrs) do
    merchant
    |> cast(attrs, [
      :description,
      :img_url,
      :bank_name,
      :bank_account_no,
      :bank_account_holder,
      :name,
      :remarks,
      :is_approved,
      :user_id
    ])

    # |> validate_required([:name, :remarks, :is_approved, :user_id])
  end
end
