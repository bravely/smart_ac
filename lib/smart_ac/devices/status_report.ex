defmodule SmartAc.Devices.StatusReport do
  use Ecto.Schema
  import Ecto.Changeset
  alias SmartAc.{
    Devices,
    Devices.StatusReport,
    Devices.AirConditioner
  }

  @unsafe_device_health ~w(needs_service needs_new_filter gas_leak)

  schema "status_reports" do
    field :carbon_monoxide_ppm, :integer
    field :device_health, :string
    field :humidity, :integer
    field :temperature, :integer
    field :reported_at, :utc_datetime, default: Ecto.DateTime.utc

    belongs_to :air_conditioner, AirConditioner

    timestamps()
  end

  @doc false
  def changeset(%StatusReport{} = status_report, attrs) do
    status_report
    |> cast(attrs, [:temperature, :humidity, :carbon_monoxide_ppm, :device_health, :air_conditioner_id, :reported_at])
    |> validate_required([:temperature, :humidity, :carbon_monoxide_ppm, :device_health, :air_conditioner_id, :reported_at])
    |> prepare_changes(fn changeset ->
      if report_unsafe?(changeset) do

        ac_changeset =
          changeset
          |> get_field(:air_conditioner_id)
          |> Devices.get_air_conditioner!
          |> AirConditioner.unsafe_ac_changeset

        put_assoc(changeset, :air_conditioner, ac_changeset)
      else
        changeset
      end
    end)
  end

  def report_unsafe?(%Ecto.Changeset{} = changeset) do
    (get_field(changeset, :carbon_monoxide_ppm) >= 9) ||
      Enum.member?(@unsafe_device_health, get_field(changeset, :device_health))
  end
end
