defmodule SmartAcWeb.Guardian do
  use Guardian, otp_app: :smart_ac

  alias SmartAc.Devices

  def subject_for_token(%{serial: serial}, _claims) do
    {:ok, "AC:" <> serial}
  end
  def subject_for_token(_resource, _claims), do: {:error, :unhandled_type}

  def resource_from_claims(%{"sub" => "AC:" <> serial}) do
    case Devices.find_air_conditioner_by_serial(serial) do
      nil -> {:error, :no_air_conditioner_found}
      air_conditioner -> {:ok, air_conditioner}
    end
  end
  def resource_from_claims(_claims), do: {:error, :invalid_auth}
end
