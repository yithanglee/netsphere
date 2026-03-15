defmodule CommerceFront.Settings.SwapBackTxCheck do
  @moduledoc """
  Tracks pending on-chain transactions for swap_back so we can poll for
  confirmation before crediting the user's wallet and creating stake holding.

  One row per swap_back. A worker or cron should call
  CommerceFront.Settings.check_and_confirm_swap_back_tx/1 for pending records.

  Table: swap_back_tx_checks
  - swap_back_id (FK to swap_backs, unique)
  - tx_hash (string, required)
  - status ("pending" | "confirmed" | "failed"), default "pending"
  - last_checked_at, confirmed_at (utc_datetime, nullable)
  - check_count (integer, default 0)
  - last_error (string, nullable)
  - timestamps
  """
  use Ecto.Schema
  import Ecto.Changeset

  schema "swap_back_tx_checks" do
    field(:tx_hash, :string)
    field(:status, :string, default: "pending")
    field(:last_checked_at, :utc_datetime)
    field(:confirmed_at, :utc_datetime)
    field(:check_count, :integer, default: 0)
    field(:last_error, :string)

    belongs_to(:swap_back, CommerceFront.Settings.SwapBack)

    timestamps()
  end

  @doc false
  def changeset(swap_back_tx_check, attrs) do
    swap_back_tx_check
    |> cast(attrs, [
      :swap_back_id,
      :tx_hash,
      :status,
      :last_checked_at,
      :confirmed_at,
      :check_count,
      :last_error
    ])
    |> validate_required([:swap_back_id, :tx_hash])
    |> unique_constraint(:swap_back_id)
    |> foreign_key_constraint(:swap_back_id)
  end
end
