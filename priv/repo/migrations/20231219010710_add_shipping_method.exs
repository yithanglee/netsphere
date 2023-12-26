defmodule CommerceFront.Repo.Migrations.AddShippingMethod do
  use Ecto.Migration

  def change do
    alter table("sales") do
      add :shipping_method, :string 
      add :shipping_company, :string 
    end
  end
end
