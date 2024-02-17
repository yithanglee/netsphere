defmodule CommerceFront.Settings.MerchantWithdrawal do
  use Ecto.Schema
  import Ecto.Changeset

  schema "merchant_withdrawals" do
    field(:amount, :float)
    field(:bank_account_number, :string)
    field(:bank_name, :string)
    field(:is_paid, :boolean, default: false)
    # field :merchant_id, :integer
    belongs_to(:merchant, CommerceFront.Settings.Merchant)
    field(:paid_date, :date)
    field(:remarks, :string)

    timestamps()
  end

  @doc false
  def changeset(merchant_withdrawal, attrs) do
    merchant_withdrawal
    |> cast(attrs, [
      :amount,
      :bank_account_number,
      :bank_name,
      :is_paid,
      :paid_date,
      :remarks,
      :merchant_id
    ])
    |> validate_required([
      :amount,
      :bank_account_number,
      :bank_name,
      # :is_paid,
      # :paid_date,
      # :remarks,
      :merchant_id
    ])
  end
end
