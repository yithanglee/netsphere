defmodule CommerceFront.Repo.Migrations.CreateSalesItems do
  use Ecto.Migration

  def change do
    create table(:sales_items) do
      add :sales_id, :integer
      add :item_name, :string
      add :qty, :integer
      add :item_price, :float
      add :remarks, :string

      timestamps()
    end

  end
end
