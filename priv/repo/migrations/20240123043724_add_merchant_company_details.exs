defmodule CommerceFront.Repo.Migrations.AddMerchantCompanyDetails do
  use Ecto.Migration

  def change do
    alter table("merchants") do
      add :company_address, :string  
      add :company_email, :string  
      add :company_phone, :string 
      add :company_reg_no, :string  
      add :company_ssm_image_url, :string 
    end
  end
end
