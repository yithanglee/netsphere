defmodule CommerceFront.Repo.Migrations.CreateMemberInstalmentProducts do
  use Ecto.Migration

  def change do
    create table(:member_instalment_products) do
      add :member_instalment_id, references(:member_instalments)
      add :instalment_product_id, references(:instalment_products)

      timestamps()
    end

  end
end
