defmodule CommerceFront.Settings.StakeHolding do
  use Ecto.Schema
  import Ecto.Changeset

  schema "stake_holdings" do
    field(:original_qty, :decimal)
    field(:initial_bought, :date)
    field(:released, :decimal)

    belongs_to(:holding, CommerceFront.Settings.WalletTransaction, foreign_key: :holding_id)

    timestamps()
  end

  @doc false
  def changeset(stake_holding, attrs) do
    stake_holding
    |> cast(attrs, [:holding_id, :original_qty, :initial_bought, :released])
    |> validate_required([:holding_id, :original_qty, :initial_bought])
    |> validate_number(:original_qty, greater_than: 0)
    |> validate_number(:released, greater_than_or_equal_to: 0)
  end
end
