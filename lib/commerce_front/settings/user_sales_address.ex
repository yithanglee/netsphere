defmodule CommerceFront.Settings.UserSalesAddress do
  use Ecto.Schema
  import Ecto.Changeset

  schema "user_sales_addresses" do
    field(:city, :string)
    field(:country_id, :integer)
    field(:line1, :string)
    field(:line2, :string)
    field(:postcode, :string)
    field(:state, :string)
    field(:state_id, :integer)
    field(:user_id, :integer)
    field(:phone, :string)
    field(:fullname, :string)
    timestamps()
  end

  @doc false
  def changeset(user_sales_address, attrs) do
    user_sales_address
    |> cast(attrs, [
      :phone,
      :fullname,
      :user_id,
      :line1,
      :line2,
      :city,
      :postcode,
      :state,
      :country_id,
      :state_id
    ])

    # |> validate_required([:line1, :line2, :city, :postcode, :state, :country_id, :state_id])
  end
end
