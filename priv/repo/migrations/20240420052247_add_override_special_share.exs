defmodule CommerceFront.Repo.Migrations.AddOverrideSpecialShare do
  use Ecto.Migration

  def change do
    alter table("products") do
      add :override_special_share_payout, :boolean, default: false
      add :override_special_share_payout_perc, :float, default: 0.5
    end
  end
end
