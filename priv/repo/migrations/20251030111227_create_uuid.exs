defmodule CommerceFront.Repo.Migrations.CreateMessagingDevices do
  use Ecto.Migration

  def change do
    create table(:messaging_devices) do
      add :staff_id, :integer
      add :uuid, :string

      timestamps()
    end

  end
end
