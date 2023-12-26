defmodule CommerceFront.Repo.Migrations.CreateUserSalesAddresses do
  use Ecto.Migration

  def change do
    create table(:user_sales_addresses) do
      add :line1, :string
      add :line2, :string
      add :city, :string
      add :postcode, :string
      add :state, :string
      add :country_id, :integer
      add :state_id, :integer

      timestamps()
    end

  end
end
