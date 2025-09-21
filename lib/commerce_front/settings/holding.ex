defmodule CommerceFront.Settings.Holding do
  use Ecto.Schema
  import Ecto.Changeset

  schema "holdings" do
    field :average_price, :decimal
    field :locked, :decimal
    field :quantity, :decimal
    # field :user_id, :id
    # field :asset_id, :id
    belongs_to(:user, CommerceFront.Settings.User)
    belongs_to(:asset, CommerceFront.Settings.Asset)

    timestamps()
  end

  @doc false
  def changeset(holding, attrs) do
    holding
    |> cast(attrs, [:user_id, :asset_id, :quantity, :locked, :average_price])
    |> validate_required([:user_id, :asset_id])
    |> unique_constraint([:user_id, :asset_id])
  end
end
