defmodule CommerceFront.Settings.Placement do
  use Ecto.Schema
  import Ecto.Changeset

  schema "placements" do
    belongs_to(:parent, CommerceFront.Settings.User, foreign_key: :parent_user_id)
    # field(:parent_user_id, :integer)
    field(:parent_placement_id, :integer)
    field(:position, :string)

    field(:left, :integer, default: 0)
    field(:right, :integer, default: 0)
    # field(:user_id, :integer) 
    belongs_to(:user, CommerceFront.Settings.User)

    timestamps()
  end

  @doc false
  def changeset(placement, attrs) do
    placement
    |> cast(attrs, [:left, :right, :parent_user_id, :parent_placement_id, :user_id, :position])
    |> validate_required([:parent_placement_id, :user_id, :position])
  end
end
