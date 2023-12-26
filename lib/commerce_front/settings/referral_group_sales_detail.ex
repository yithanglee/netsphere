defmodule CommerceFront.Settings.ReferralGroupSalesDetail do
  use Ecto.Schema
  import Ecto.Changeset

  schema "referral_group_sales_details" do
    field(:before, :float)
    field(:after, :float)
    field(:amount, :float)
    field(:month, :integer)
    # field(:user_id, :integer)
    belongs_to(:user, CommerceFront.Settings.User)
    field(:sale_id, :integer)
    # field(:referral_group_sales_summary_id, :integer)
    belongs_to(:referral_group_sales_summary, CommerceFront.Settings.ReferralGroupSalesSummary)
    field(:year, :integer)

    timestamps()
  end

  @doc false
  def changeset(referral_group_sales_detail, attrs) do
    referral_group_sales_detail
    |> cast(attrs, [
      :month,
      :year,
      :amount,
      :user_id,
      :sale_id,
      :referral_group_sales_summary_id,
      :before,
      :after
    ])
    |> validate_required([:amount, :user_id])
  end
end
