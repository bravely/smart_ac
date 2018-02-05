defmodule SmartAc.Devices.StatusReport do
  use Ecto.Schema
  import Ecto.Changeset
  alias SmartAc.Devices.StatusReport


  schema "status_reports" do
    field :carbon_monoxide_ppm, :integer
    field :device_health, :string
    field :humidity, :integer
    field :temperature, :integer
    field :air_conditioner_id, :id

    timestamps()
  end

  @doc false
  def changeset(%StatusReport{} = status_report, attrs) do
    status_report
    |> cast(attrs, [:temperature, :humidity, :carbon_monoxide_ppm, :device_health, :air_conditioner_id])
    |> validate_required([:temperature, :humidity, :carbon_monoxide_ppm, :device_health, :air_conditioner_id])
  end
end
