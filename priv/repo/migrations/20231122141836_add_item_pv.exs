defmodule CommerceFront.Repo.Migrations.AddItemPv do
  use Ecto.Migration

  def change do
    alter table("sales_items") do
      add :item_pv, :integer 
      add :img_url, :string
    end
  end
end
