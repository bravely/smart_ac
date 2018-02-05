defmodule SmartAc.Repo.Migrations.CreateStatusReports do
  use Ecto.Migration

  def change do
    create table(:status_reports) do
      add :temperature, :integer
      add :humidity, :integer
      add :carbon_monoxide_ppm, :integer
      add :device_health, :string
      add :air_conditioner_id, references(:air_conditioners, on_delete: :nothing)

      timestamps()
    end

    create index(:status_reports, [:air_conditioner_id])
  end
end
