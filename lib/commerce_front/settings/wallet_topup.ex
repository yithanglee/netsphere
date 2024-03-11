defmodule CommerceFront.Settings.WalletTopup do
  use Ecto.Schema
  import Ecto.Changeset

  schema "wallet_topups" do
    field(:payment_method, :string, default: "fpx")
    field(:amount, :float)
    field(:img_url, :string)
    field(:is_approved, :boolean, default: false)
    field(:remarks, :string)
    field(:bank, :string)
    # field(:user_id, :integer)
    belongs_to(:user, CommerceFront.Settings.User)
    has_one(:payment, CommerceFront.Settings.Payment)

    timestamps()
  end

  @doc false
  def changeset(wallet_topup, attrs) do
    wallet_topup
    |> cast(attrs, [:bank, :payment_method, :user_id, :amount, :remarks, :is_approved, :img_url])

    # |> validate_required([:user_id, :amount, :remarks, :is_approved, :img_url])
  end
end
