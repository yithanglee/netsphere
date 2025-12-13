defmodule CommerceFront.Repo.Migrations.AddMerchantIdToPickUpPoints do
  use Ecto.Migration

  def change do
    alter table(:merchant_pick_up_points) do
      add :merchant_id, references(:merchants)
    end

    create index(:merchant_pick_up_points, [:merchant_id])
  end
end
