defmodule CommerceFront.Settings.PlacementGroupSalesDetail do
  use Ecto.Schema
  import Ecto.Changeset

  schema "placement_group_sales_details" do
    field(:after, :integer)
    field(:amount, :integer)
    field(:before, :integer)
    # field :from_user_id, :integer
    belongs_to(:from_user, CommerceFront.Settings.User)
    field(:position, :string)
    field(:remarks, :string)
    field(:sales_id, :integer)
    # field :to_user_id, :integer

    belongs_to(:to_user, CommerceFront.Settings.User)
    timestamps()
  end

  @doc false
  def changeset(placement_group_sales_detail, attrs) do
    placement_group_sales_detail
    |> cast(attrs, [
      :before,
      :after,
      :amount,
      :remarks,
      :from_user_id,
      :to_user_id,
      :sales_id,
      :position
    ])
    |> validate_required([
      :before,
      :after,
      :amount,
      :remarks,
      :from_user_id,
      :to_user_id,
      :sales_id,
      :position
    ])
  end
end
