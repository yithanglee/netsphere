defmodule CommerceFront.Repo.Migrations.AddCommissionPercToProduct do
  use Ecto.Migration

  def change do
    alter table("merchant_products") do
      add :commission_perc, :float, default: 0.1
    end
  end
end
