defmodule CommerceFront.Repo.Migrations.AddPhoneNFullnameToUsa do
  use Ecto.Migration

  def change do
    alter table("user_sales_addresses") do
      add :phone, :string
      add :fullname, :string
    end
  end
end
