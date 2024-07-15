defmodule CommerceFront.Settings.Referral do
  use Ecto.Schema
  import Ecto.Changeset

  schema "referrals" do
    field(:parent_referral_id, :integer)
    # field(:parent_user_id, :integer)
    belongs_to(:parent_user, CommerceFront.Settings.User)
    field(:user_id, :integer)

    timestamps()
  end

  @doc false
  def changeset(referral, attrs) do
    referral
    |> cast(attrs, [:user_id, :parent_user_id, :parent_referral_id])
    |> validate_required([:user_id, :parent_user_id, :parent_referral_id])
  end
end
