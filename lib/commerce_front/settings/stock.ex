defmodule CommerceFront.Settings.Stock do
  use Ecto.Schema
  import Ecto.Changeset

  schema "stocks" do
    field(:desc, :string)
    field(:name, :string)

    timestamps()
  end

  @doc false
  def changeset(stock, attrs) do
    stock
    |> cast(attrs, [:name, :desc])
    |> validate_required([:name, :desc])
  end
end
