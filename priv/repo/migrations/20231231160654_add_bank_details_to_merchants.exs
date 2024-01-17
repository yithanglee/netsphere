defmodule CommerceFront.Repo.Migrations.AddBankDetailsToMerchants do
  use Ecto.Migration

  def change do
    alter table("merchants") do
       add :bank_name, :string
       add :bank_account_holder, :string 
       add :bank_account_no, :string 
       add :description, :binary
       add :img_url, :string
    end
  end
end
