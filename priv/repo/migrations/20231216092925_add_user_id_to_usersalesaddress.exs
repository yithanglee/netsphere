defmodule CommerceFront.Repo.Migrations.AddUserIdToUsersalesaddress do
  use Ecto.Migration

  def change do
    alter table("user_sales_addresses") do 
      add :user_id, :integer
    end 
  end
end
