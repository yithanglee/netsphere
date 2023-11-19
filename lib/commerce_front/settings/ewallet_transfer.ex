defmodule CommerceFront.Settings.EwalletTransfer do
  use Ecto.Schema
  import Ecto.Changeset

  schema "ewallet_transfers" do
    field(:amount, :string)
    field(:approved_by, :string)
    field(:approved_datetime, :naive_datetime)
    field(:from_username, :string)
    belongs_to(:from_user, CommerceFront.Settings.User)

    belongs_to(:to_user, CommerceFront.Settings.User)
    field(:img_url, :string)
    field(:is_approved, :boolean, default: false)
    field(:remarks, :string)
    field(:to_username, :string)
    # field(:wallet_type, :string)
    belongs_to(:wallet_type, CommerceFront.Settings.WalletType)
    timestamps()
  end

  @doc false
  def changeset(ewallet_transfer, attrs) do
    ewallet_transfer
    |> cast(attrs, [
      :to_username,
      :from_username,
      :from_user_id,
      :to_user_id,
      :wallet_type_id,
      :amount,
      :is_approved,
      :approved_by,
      :approved_datetime,
      :remarks,
      :img_url
    ])
    |> validate_required([
      :from_username,
      :to_username,
      :wallet_type_id,
      :amount
      # :is_approved,
      # :approved_by,
      # :approved_datetime,
      # :remarks,
      # :img_url
    ])
  end
end
