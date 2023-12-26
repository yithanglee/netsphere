defmodule CommerceFront.Settings.ShareLink do
  use Ecto.Schema
  import Ecto.Changeset

  schema "share_links" do
    field(:position, :string)
    field(:share_code, :string)
    # field :user_id, :integer
    belongs_to(:user, CommerceFront.Settings.User)
    timestamps()
  end

  @doc false
  def changeset(share_link, attrs) do
    share_link
    |> cast(attrs, [:user_id, :share_code, :position])
    |> validate_required([:user_id, :share_code, :position])
  end
end
