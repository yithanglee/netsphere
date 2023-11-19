defmodule CommerceFront.Repo.Migrations.CreatePayments do
  use Ecto.Migration

  def change do
    create table(:payments) do
      add :sales_id, :integer
      add :amount, :float
      add :billplz_code, :string
      add :payment_url, :string
      add :webhook_details, :binary

      timestamps()
    end

  end
end
