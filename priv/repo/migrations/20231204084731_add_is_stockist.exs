defmodule CommerceFront.Repo.Migrations.AddIsStockist do
  use Ecto.Migration

  def change do
    alter table("users") do
       add :is_stockist, :boolean, default: false
    end
  end
end
