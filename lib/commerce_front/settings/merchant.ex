defmodule CommerceFront.Settings.Merchant do
  use Ecto.Schema
  import Ecto.Changeset

  schema "merchants" do
    field(:is_approved, :boolean, default: false)
    field(:name, :string)
    field(:remarks, :string)
    # field(:user_id, :integer)
    belongs_to(:user, CommerceFront.Settings.User)
    belongs_to(:country, CommerceFront.Settings.Country)
    belongs_to(:merchant_category, CommerceFront.Settings.MerchantCategory)
    has_many(:merchant_products, CommerceFront.Settings.MerchantProduct)
    field(:description, :binary)
    field(:img_url, :string)
    field(:bank_name, :string)
    field(:bank_account_holder, :string)
    field(:bank_account_no, :string)

    field(:company_address, :string)
    field(:company_email, :string)
    field(:company_phone, :string)
    field(:company_reg_no, :string)
    field(:company_ssm_image_url, :string)
    field(:commission_perc, :float, default: 0.1)
    field(:line_id, :string)
    field(:facebook_url, :string)
    field(:instagram_id, :string)
    field(:twitter_url, :string)
    field(:youtube_url, :string)
    field(:tiktok_url, :string)
    field(:pinterest_url, :string)
    field(:linkedin_url, :string)
    field(:github_url, :string)
    field(:whatsapp_number, :string)
    field(:wechat_number, :string)
    timestamps()
  end

  @doc false
  def changeset(merchant, attrs) do
      merchant
      |> cast(attrs, [
      :whatsapp_number,
      :wechat_number,
      :line_id,
      :facebook_url,
      :instagram_id,
      :twitter_url,
      :youtube_url,
      :tiktok_url,
      :pinterest_url,
      :linkedin_url,
      :github_url,
      :country_id,
      :merchant_category_id,
      :company_address,
      :company_email,
      :company_phone,
      :company_reg_no,
      :company_ssm_image_url,
      :commission_perc,
      :description,
      :img_url,
      :bank_name,
      :bank_account_no,
      :bank_account_holder,
      :name,
      :remarks,
      :is_approved,
      :user_id
    ])

    # |> validate_required([:name, :remarks, :is_approved, :user_id])
  end
end
