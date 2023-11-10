defmodule CommerceFront.Repo.Migrations.AddNewLeftRight do
  use Ecto.Migration

  def change do
    alter table("group_sales_summaries") do
      add :new_left , :integer, default: 0 
      add :new_right , :integer, default: 0 
    end
  end
end
