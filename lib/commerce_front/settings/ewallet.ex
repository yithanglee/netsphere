defmodule CommerceFront.Settings.Ewallet do
  use Ecto.Schema
  import Ecto.Changeset
  import EctoEnum

  defenum(
    WalletTypeEnum,
    ~w(
     bonus
     product
     register
     direct_recruitment
     reserve
     travel
    )
  )

  schema "ewallets" do
    field(:total, :float)
    # field :user_id, :integer
    belongs_to(:user, CommerceFront.Settings.User)
    field(:wallet_type, WalletTypeEnum, default: :bonus)

    timestamps()
  end

  @doc false
  def changeset(ewallet, attrs) do
    ewallet
    |> cast(attrs, [:user_id, :wallet_type, :total])
    |> validate_required([:user_id, :wallet_type, :total])
  end
end

defmodule CommerceFront.Settings.WalletTransaction do
  use Ecto.Schema
  import Ecto.Changeset

  schema "wallet_transactions" do
    field(:after, :float)
    field(:amount, :float)
    field(:before, :float)
    field(:remarks, :binary)
    # field(:user_id, :integer)
    belongs_to(:user, CommerceFront.Settings.User)
    # field(:ewallet_id, :integer)
    belongs_to(:ewallet, CommerceFront.Settings.Ewallet)

    timestamps()
  end

  @doc false
  def changeset(wallet_transaction, attrs) do
    wallet_transaction
    |> cast(attrs, [:before, :after, :amount, :remarks, :user_id, :ewallet_id])
    |> validate_required([:before, :after, :amount, :remarks, :user_id, :ewallet_id])
  end
end
