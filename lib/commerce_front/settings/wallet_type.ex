defmodule CommerceFront.Settings.WalletType do
  use Ecto.Schema
  import Ecto.Changeset

  schema "wallet_types" do
    field(:cname, :string)
    field(:desc, :string)
    field(:name, :string)

    timestamps()
  end

  @doc false
  def changeset(wallet_type, attrs) do
    wallet_type
    |> cast(attrs, [:name, :desc, :cname])
    |> validate_required([:name])
  end
end
