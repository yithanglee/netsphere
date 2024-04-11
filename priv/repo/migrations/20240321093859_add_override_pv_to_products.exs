defmodule CommerceFront.Repo.Migrations.AddOverridePvToProducts do
  use Ecto.Migration

  def change do
    alter table("products") do
       add :override_pv, :boolean 
       add :override_pv_amount, :integer
    end
  end
end
