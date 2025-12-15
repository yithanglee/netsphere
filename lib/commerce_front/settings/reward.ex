defmodule CommerceFront.Settings.Reward do
  use Ecto.Schema
  import Ecto.Changeset

  schema "rewards" do
    field(:amount, :float)
    field(:day, :integer)
    field(:is_paid, :boolean, default: false)
    field(:month, :integer)
    field(:name, :string)
    field(:remarks, :binary)
    field(:sales_id, :integer)
    field(:is_withheld, :boolean, default: false)

    belongs_to(:user, CommerceFront.Settings.User)
    field(:year, :integer)

    timestamps()
  end

  @doc false
  def changeset(reward, attrs) do
    reward
    |> cast(attrs, [
      :is_paid,
      :is_withheld,
      :remarks,
      :user_id,
      :amount,
      :day,
      :month,
      :year,
      :sales_id,
      :name
    ])
    |> validate_required([
      :is_paid,
      :is_withheld,
      :remarks,
      :user_id,
      :amount,
      :day,
      :month,
      :year,
      :sales_id,
      :name
    ])
  end
end
