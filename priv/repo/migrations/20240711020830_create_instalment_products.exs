defmodule CommerceFront.Repo.Migrations.CreateInstalmentProducts do
  use Ecto.Migration

  def change do
    create table(:instalment_products) do
      add :product_id, references(:products)
      add :instalment_id, references(:instalments)
      add :instalment_product_id, :integer
      add :qty, :integer
      add :month_no, :integer

      timestamps()
    end

  end
end
