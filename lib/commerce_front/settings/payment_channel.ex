defmodule CommerceFront.Settings.PaymentChannel do
  use Ecto.Schema
  import Ecto.Changeset

  schema "payment_channels" do
    field(:active, :boolean, default: false)
    field(:category, :string)
    field(:code, :string)

    timestamps()
  end

  @doc false
  def changeset(payment_channel, attrs) do
    payment_channel
    |> cast(attrs, [:category, :active, :code])
    |> validate_required([:category, :active, :code])
  end
end
