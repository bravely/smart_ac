defmodule SmartAc.Repo.Migrations.CreateAirConditioners do
  use Ecto.Migration

  def change do
    create table(:air_conditioners) do
      add :serial, :string
      add :registered_at, :utc_datetime
      add :firmware_version, :string

      timestamps()
    end

    create unique_index(:air_conditioners, [:serial])
  end
end
