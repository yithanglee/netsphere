defmodule CommerceFront.Settings.MemberInstalment do
  use Ecto.Schema
  import Ecto.Changeset

  schema "member_instalments" do
    field(:due_date, :date)
    # field(:instalment_id, :integer)
    belongs_to(:instalment, CommerceFront.Settings.Instalment)
    field(:is_paid, :boolean, default: false)
    field(:month_no, :integer)
    # field(:product_id, :integer)
    belongs_to(:product, CommerceFront.Settings.Product)
    # field :user_id, :integer
    belongs_to(:user, CommerceFront.Settings.User)
    has_one(:member_instalment_product, CommerceFront.Settings.MemberInstalmentProduct)
    has_one(:freebie, through: [:member_instalment_product, :product])
    has_one(:referral, through: [:user, :referral])
    has_one(:sponsor, through: [:referral, :parent_user])
    has_many(:parent_ewallets, through: [:sponsor, :ewallets])
    timestamps()
  end

  @doc false
  def changeset(member_instalment, attrs) do
    member_instalment
    |> cast(attrs, [:user_id, :product_id, :instalment_id, :month_no, :due_date, :is_paid])
    |> validate_required([:user_id, :product_id, :instalment_id, :month_no, :due_date, :is_paid])
  end
end
