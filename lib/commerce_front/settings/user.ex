defmodule CommerceFront.Settings.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field(:approved, :boolean, default: false)
    field(:bank_account_holder, :string)
    field(:bank_account_no, :string)
    field(:bank_name, :string)
    field(:blocked, :boolean, default: false)
    field(:crypted_password, :string)
    field(:password, :string, virtual: true)
    field(:email, :string)
    field(:fullname, :string)
    field(:ic_no, :string)
    field(:phone, :string)
    field(:rank_name, :string)
    field(:username, :string)
    belongs_to(:rank, CommerceFront.Settings.Rank)
    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [
      :rank_id,
      :email,
      :username,
      :fullname,
      :phone,
      :ic_no,
      :crypted_password,
      :approved,
      :blocked,
      :rank_name,
      :bank_account_holder,
      :bank_account_no,
      :bank_name
    ])
    |> validate_required([
      :email,
      :username,
      :fullname,
      :phone
      # :ic_no,
      # :crypted_password,
      # :approved,
      # :blocked,
      # :rank_name,
      # :bank_account_holder,
      # :bank_account_no,
      # :bank_name
    ])
  end
end
