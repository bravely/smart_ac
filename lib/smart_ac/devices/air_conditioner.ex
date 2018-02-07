defmodule SmartAc.Devices.AirConditioner do
  use Ecto.Schema
  import Ecto.Changeset
  alias SmartAc.Devices.AirConditioner


  schema "air_conditioners" do
    field :firmware_version, :string
    field :registered_at, :utc_datetime
    field :serial, :string

    timestamps()
  end

  @doc false
  def changeset(%AirConditioner{} = air_conditioner, attrs) do
    air_conditioner
    |> cast(attrs, [:serial, :registered_at, :firmware_version])
    |> validate_required([:serial, :registered_at, :firmware_version])
    |> unsafe_validate_unique([:serial], SmartAc.Repo)
    |> unique_constraint(:serial)
  end
end
