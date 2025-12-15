defmodule CommerceFront.Settings.Order do
  use Ecto.Schema
  import Ecto.Changeset

  schema "orders" do
    field(:idempotency_key, :string)
    field(:meta, :map)
    field(:order_type, :string)
    field(:price, :decimal)
    field(:qty, :decimal)
    field(:qty_filled, :decimal)
    field(:side, :string)
    field(:source, :string)
    field(:status, :string)
    field(:user_id, :id)
    field(:asset_id, :id)

    timestamps()
  end

  @doc false
  def changeset(order, attrs) do
    order
    |> cast(attrs, [
      :user_id,
      :asset_id,
      :side,
      :source,
      :order_type,
      :qty,
      :qty_filled,
      :price,
      :status,
      :idempotency_key,
      :meta
    ])
    |> validate_required([:user_id, :asset_id, :side, :source, :order_type, :qty])
    |> unique_constraint([:user_id, :idempotency_key], name: :orders_idemp_unique)
  end
end
