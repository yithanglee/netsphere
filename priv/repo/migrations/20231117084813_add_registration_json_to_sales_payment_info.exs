defmodule CommerceFront.Repo.Migrations.AddRegistrationJsonToSalesPaymentInfo do
  use Ecto.Migration

  def change do
    alter table("sales") do
      add :registration_details, :binary 
      add :payment_id, :integer
    end
  end
end
