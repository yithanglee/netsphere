defmodule CommerceFront.Settings.Sale do
  use Ecto.Schema
  import Ecto.Changeset

  schema "sales" do
    field :month, :integer
    field :remarks, :string
    field :sale_date, :date
    field :status, :string
    field :subtotal, :float
    field :total_point_value, :integer
    field :user_id, :integer
    field :year, :integer

    timestamps()
  end

  @doc false
  def changeset(sale, attrs) do
    sale
    |> cast(attrs, [:sale_date, :month, :year, :subtotal, :user_id, :status, :total_point_value, :remarks])
    |> validate_required([:sale_date, :month, :year, :subtotal, :user_id, :status, :total_point_value, :remarks])
  end
end
