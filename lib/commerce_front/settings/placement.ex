defmodule CommerceFront.Settings.Placement do
  use Ecto.Schema
  import Ecto.Changeset

  schema "placements" do
    field(:parent_user_id, :integer)
    field(:parent_placement_id, :integer)
    field(:position, :string)
    field(:user_id, :integer)

    timestamps()
  end

  @doc false
  def changeset(placement, attrs) do
    placement
    |> cast(attrs, [:parent_user_id, :parent_placement_id, :user_id, :position])
    |> validate_required([:parent_placement_id, :user_id, :position])
  end
end
