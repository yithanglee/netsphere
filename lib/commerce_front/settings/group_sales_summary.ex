defmodule CommerceFront.Settings.GroupSalesSummary do
  use Ecto.Schema
  import Ecto.Changeset

  schema "group_sales_summaries" do
    field(:balance_left, :integer, default: 0)
    field(:balance_right, :integer, default: 0)
    field(:day, :integer)
    field(:month, :integer)
    field(:paired, :integer)
    field(:total_left, :integer, default: 0)
    field(:total_right, :integer, default: 0)
    field(:new_left, :integer, default: 0)
    field(:new_right, :integer, default: 0)
    # field(:user_id, :integer)
    belongs_to(:user, CommerceFront.Settings.User)
    field(:year, :integer)

    timestamps()
  end

  @doc false
  def changeset(group_sales_summary, attrs) do
    group_sales_summary
    |> cast(attrs, [
      :new_left,
      :new_right,
      :user_id,
      :day,
      :month,
      :year,
      :balance_left,
      :balance_right,
      :total_left,
      :total_right,
      :paired
    ])

    # |> validate_required([:user_id, :day, :month, :year, :balance_left, :balance_right, :total_left, :total_right, :paired])
  end
end
