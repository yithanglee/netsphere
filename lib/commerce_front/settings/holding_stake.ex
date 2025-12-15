defmodule CommerceFront.Settings.HoldingStake do
  use Ecto.Schema
  import Ecto.Changeset

  schema "holding_stakes" do
    field(:original_qty, :decimal)
    field(:remaining_locked_qty, :decimal)
    field(:daily_release_qty, :decimal)
    field(:days_total, :integer, default: 100)
    field(:days_released, :integer, default: 0)
    field(:last_release_date, :date)
    field(:status, :string, default: "active")
    field(:user_id, :id)
    field(:asset_id, :id)

    timestamps()
  end

  @doc false
  def changeset(model, attrs) do
    model
    |> cast(attrs, [
      :user_id,
      :asset_id,
      :original_qty,
      :remaining_locked_qty,
      :daily_release_qty,
      :days_total,
      :days_released,
      :last_release_date,
      :status
    ])
    |> validate_required([
      :user_id,
      :asset_id,
      :original_qty,
      :remaining_locked_qty,
      :daily_release_qty
    ])
  end
end
