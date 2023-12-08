defmodule CommerceFront.Repo.Migrations.AddPaidDateToWb do
  use Ecto.Migration

  def change do
    alter table("withdrawal_batches") do
       add :paid_date, :date
    end
  end
end
