defmodule CommerceFront.Settings.SwapBack do
  use Ecto.Schema
  import Ecto.Changeset

  schema "swap_backs" do
    field(:amount, :decimal)
    field(:amount_raw, :integer)
    field(:approved_at, :naive_datetime)
    field(:points_credited, :string)
    field(:rate_used, :string)
    field(:reason, :string)
    # field :staff_id, :integer
    belongs_to(:staff, CommerceFront.Settings.Staff)
    field(:status, :string, default: "pending")
    field(:treasury_address, :string)
    field(:tx_hash, :string)
    # field :user_id, :integer
    belongs_to(:user, CommerceFront.Settings.User)
    field(:user_wallet_address, :string)

    timestamps()
  end

  @doc false
  def changeset(swap_back, attrs) do
    swap_back
    |> cast(attrs, [
      :user_id,
      :user_wallet_address,
      :treasury_address,
      :amount_raw,
      :amount,
      :tx_hash,
      :status,
      :reason,
      :staff_id,
      :approved_at,
      :rate_used,
      :points_credited
    ])
    |> validate_required([
      :user_id,
      :user_wallet_address,
      :treasury_address,
      # :amount_raw,
      :amount
      # :tx_hash,
      # :status,
      # :reason,
      # :staff_id,
      # :approved_at,
      # :rate_used,
      # :points_credited
    ])
  end
end
