defmodule CommerceFront.Settings.ReferralGroupSalesSummary do
  use Ecto.Schema
  import Ecto.Changeset

  schema "referral_group_sales_summaries" do
    field(:amount, :float)
    field(:month, :integer)
    # field(:user_id, :integer)
    belongs_to(:user, CommerceFront.Settings.User)
    field(:year, :integer)

    timestamps()
  end

  @doc false
  def changeset(referral_group_sales_summary, attrs) do
    referral_group_sales_summary
    |> cast(attrs, [:month, :year, :user_id, :amount])
    |> validate_required([:month, :year, :user_id, :amount])
  end
end
