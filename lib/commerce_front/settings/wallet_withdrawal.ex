defmodule CommerceFront.Settings.WalletWithdrawal do
  use Ecto.Schema
  import Ecto.Changeset
  import EctoEnum

  defenum(WithdrawalTypeEnum, ~w(bonus active_token))

  schema "wallet_withdrawals" do
    field(:amount, :float)
    field(:bank_account_number, :string)
    field(:amount_in_myr, :float, default: 0.0)
    field(:processing_fee, :float, default: 0.0)
    field(:final_amount_in_myr, :float, default: 0.0)
    field(:withdrawal_type, WithdrawalTypeEnum, default: :bonus)
    field(:processing_fee_in_myr, :float, default: 0.0)
    field(:bank_name, :string)
    field(:is_paid, :boolean, default: false)
    field(:paid_date, :date)
    field(:remarks, :string)
    # field :user_id, :integer
    belongs_to(:user, CommerceFront.Settings.User)
    field(:tx_hash, :string)
    # field :withdrawal_batch_id, :integer
    belongs_to(:withdrawal_batch, CommerceFront.Settings.WithdrawalBatch)

    timestamps()
  end

  @doc false
  def changeset(wallet_withdrawal, attrs) do
    wallet_withdrawal
    |> cast(attrs, [
      :tx_hash,
      :withdrawal_type,
      :amount_in_myr,
      :processing_fee,
      :processing_fee_in_myr,
      :final_amount_in_myr,
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
