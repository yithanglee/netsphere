defmodule CommerceFront.Repo.Migrations.CreateMemberInstalments do
  use Ecto.Migration

  def change do
    create table(:member_instalments) do
      add :user_id, :integer
      add :product_id, :integer
      add :instalment_id, :integer
      add :month_no, :integer
      add :due_date, :date
      add :is_paid, :boolean, default: false, null: false

      timestamps()
    end

  end
end
