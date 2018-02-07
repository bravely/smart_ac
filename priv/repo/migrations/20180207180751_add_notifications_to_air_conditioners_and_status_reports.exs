defmodule SmartAc.Repo.Migrations.AddNotificationsToAirConditionersAndStatusReports do
  use Ecto.Migration

  def change do
    alter table(:air_conditioners) do
      add :safe, :boolean, default: true
    end

    alter table(:status_reports) do
      add :reported_at, :utc_datetime
    end
  end
end
