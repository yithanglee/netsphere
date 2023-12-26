defmodule CommerceFront.Repo.Migrations.AddShippingRefToSales do
  use Ecto.Migration

  def change do
    alter table("sales") do
      add :shipping_ref, :string 
    end

    alter table("products") do
       remove :desc, :string 
       add :desc , :binary
    end
  end
end
