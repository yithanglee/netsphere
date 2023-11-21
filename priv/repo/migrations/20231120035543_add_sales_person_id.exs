defmodule CommerceFront.Repo.Migrations.AddSalesPersonId do
  use Ecto.Migration

  def change do
    alter table("sales") do
      add :sales_person_id, :integer
    end
  end
end
