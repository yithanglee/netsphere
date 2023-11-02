defmodule CommerceFront.Repo.Migrations.CreatePlacementGroupSalesDetails do
  use Ecto.Migration

  def change do
    create table(:placement_group_sales_details) do
      add :before, :integer
      add :after, :integer
      add :amount, :integer
      add :remarks, :string
      add :from_user_id, :integer
      add :to_user_id, :integer
      add :sales_id, :integer
      add :position, :string

      timestamps()
    end

  end
end
