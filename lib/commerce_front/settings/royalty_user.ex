defmodule CommerceFront.Settings.RoyaltyUser do
  use Ecto.Schema
  import Ecto.Changeset

  schema "royalty_users" do
    field(:perc, :float)
    # field :user_id, :integer
    belongs_to(:user, CommerceFront.Settings.User)
    timestamps()
  end

  @doc false
  def changeset(royalty_user, attrs) do
    royalty_user
    |> cast(attrs, [:user_id, :perc])
    |> validate_required([:user_id, :perc])
  end
end
