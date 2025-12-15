defmodule CommerceFront.Settings.Balance do
  use Ecto.Schema
  import Ecto.Changeset

  schema "balances" do
    field(:available, :decimal)
    field(:currency, :string)
    field(:locked, :decimal)
    # field :user_id, :integer
    belongs_to(:user, CommerceFront.Settings.User)

    timestamps()
  end

  @doc false
  def changeset(balance, attrs) do
    balance
    |> cast(attrs, [:user_id, :currency, :available, :locked])
    |> validate_required([:user_id, :currency, :available, :locked])
  end
end
