defmodule CommerceFront.Repo.Migrations.ModifyTpvToFloat do
  use Ecto.Migration

 def up do
    alter table(:sales) do
      modify :total_point_value, :float
    end
  end

  def down do
    alter table(:sales) do
      modify :total_point_value, :integer
    end
  end
end
