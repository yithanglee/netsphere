defmodule CommerceFront.Settings.Instalment do
  use Ecto.Schema
  import Ecto.Changeset

  schema "instalments" do
    field(:name, :string)
    field(:no_of_months, :integer)

    field(:delay, :integer, default: 0)
    timestamps()
  end

  @doc false
  def changeset(instalment, attrs) do
    instalment
    |> cast(attrs, [:name, :no_of_months, :delay])
    |> validate_required([:name, :no_of_months])
  end
end
