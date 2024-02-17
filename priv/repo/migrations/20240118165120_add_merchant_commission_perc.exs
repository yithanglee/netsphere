defmodule CommerceFront.Repo.Migrations.AddMerchantCommissionPerc do
  use Ecto.Migration

  def change do
    alter table("merchants") do
      add :commission_perc, :float, default: 0.1
    end

    alter table("sales") do
       add :merchant_id, :integer
    end
  end
end
