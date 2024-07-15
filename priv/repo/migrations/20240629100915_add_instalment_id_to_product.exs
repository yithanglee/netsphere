defmodule CommerceFront.Repo.Migrations.AddInstalmentIdToProduct do
  use Ecto.Migration

  def change do
    alter table("products") do 
      add :instalment_id, :integer 
      add :is_instalment, :boolean, default: false  
      add :first_payment_product_id, :integer  
    end
  end
end
