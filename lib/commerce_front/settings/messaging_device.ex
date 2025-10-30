defmodule CommerceFront.Settings.MessagingDevice do
  use Ecto.Schema
  import Ecto.Changeset

  schema "messaging_devices" do
    field :staff_id, :integer
    field :uuid, :string
    timestamps()
  end

  @doc false
  def changeset(messaging_device, attrs) do
    messaging_device
    |> cast(attrs, [:staff_id, :uuid])
    |> validate_required([:staff_id, :uuid])
  end
end
