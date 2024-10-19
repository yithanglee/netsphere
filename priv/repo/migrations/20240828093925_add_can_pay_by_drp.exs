defmodule CommerceFront.Repo.Migrations.AddCanPayByDrp do
  use Ecto.Migration

  def change do
    alter table("products") do
      add :can_pay_by_drp , :boolean, default: true
    end
  end
end
