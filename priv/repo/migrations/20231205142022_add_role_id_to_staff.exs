defmodule CommerceFront.Repo.Migrations.AddRoleIdToStaff do
  use Ecto.Migration

  def change do
    alter table("staffs") do
      add :role_id, references(:roles)
    end
  end
end
