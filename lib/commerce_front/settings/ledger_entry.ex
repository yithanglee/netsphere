defmodule CommerceFront.Settings.LedgerEntry do
  use Ecto.Schema
  import Ecto.Changeset

  schema "ledger_entries" do
    field :amount, :decimal
    field :currency, :string
    field :direction, :string
    field :journal, :string
    field :reference, :map
    field :user_id, :id
    field :asset_id, :id

    timestamps()
  end

  @doc false
  def changeset(ledger_entry, attrs) do
    ledger_entry
    |> cast(attrs, [:user_id, :asset_id, :journal, :currency, :amount, :direction, :reference])
    |> validate_required([:journal, :amount, :direction])
  end
end
