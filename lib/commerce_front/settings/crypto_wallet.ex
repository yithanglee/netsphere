defmodule CommerceFront.Settings.CryptoWallet do
  use Ecto.Schema
  import Ecto.Changeset

  schema "crypto_wallets" do
    field(:address, :string)
    field(:private_key, :string)
    field(:public_key, :string)
    field(:user_id, :integer)
    field(:second_password, :string)

    timestamps()
  end

  @doc false
  def changeset(crypto_wallet, attrs) do
    crypto_wallet
    |> cast(attrs, [:user_id, :address, :private_key, :public_key, :second_password])
    |> validate_required([:user_id, :address, :private_key, :public_key])
  end
end
