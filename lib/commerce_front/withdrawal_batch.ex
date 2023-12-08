defmodule CommerceFront.Settings.WithdrawalBatch do
  use Ecto.Schema
  import Ecto.Changeset

  schema "withdrawal_batches" do
    field(:day, :integer)
    field(:month, :integer)
    field(:remarks, :binary)
    field(:year, :integer)
    field(:code, :string)
    field(:is_open, :boolean, default: false)
    field(:paid_date, :date)
    timestamps()
  end

  @doc false
  def changeset(withdrawal_batch, attrs) do
    withdrawal_batch
    |> cast(attrs, [:paid_date, :code, :day, :month, :year, :remarks, :is_open])

    # |> validate_required([:day, :month, :year, :remarks])
  end
end
