defmodule CommerceFront.Settings.WalletWithdrawal do
  use Ecto.Schema
  import Ecto.Changeset

  schema "wallet_withdrawals" do
    field(:amount, :float)
    field(:bank_account_number, :string)
    field(:bank_name, :string)
    field(:is_paid, :boolean, default: false)
    field(:paid_date, :date)
    field(:remarks, :string)
    # field :user_id, :integer
    belongs_to(:user, CommerceFront.Settings.User)

    # field :withdrawal_batch_id, :integer
    belongs_to(:withdrawal_batch, CommerceFront.Settings.WithdrawalBatch)

    timestamps()
  end

  @doc false
  def changeset(wallet_withdrawal, attrs) do
    wallet_withdrawal
    |> cast(attrs, [
      :user_id,
      :amount,
      :remarks,
      :is_paid,
      :withdrawal_batch_id,
      :paid_date,
      :bank_name,
      :bank_account_number
    ])
    |> validate_required([
      # :user_id,
      :amount,
      # :remarks,
      # :is_paid,
      :withdrawal_batch_id,
      # :paid_date,
      :bank_name,
      :bank_account_number
    ])
  end
end
