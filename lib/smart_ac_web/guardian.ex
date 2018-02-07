defmodule SmartAcWeb.Guardian do
  use Guardian, otp_app: :smart_ac

  alias SmartAc.{Devices, Accounts}

  def subject_for_token(%Devices.AirConditioner{serial: serial}, _claims) do
    {:ok, "AC:" <> serial}
  end
  def subject_for_token(%Accounts.User{id: user_id}, _claims) do
    {:ok, "User:" <> to_string(user_id)}
  end
  def subject_for_token(_resource, _claims), do: {:error, :unhandled_type}

  def resource_from_claims(%{"sub" => "AC:" <> serial}) do
    case Devices.find_air_conditioner_by_serial(serial) do
      nil -> {:error, :no_air_conditioner_found}
      air_conditioner -> {:ok, air_conditioner}
    end
  end
  def resource_from_claims(%{"sub" => "User:" <> user_id}) do
    case Accounts.get_user!(String.to_integer(user_id)) do
      nil -> {:error, :no_user_found}
      user -> {:ok, user}
    end
  end
  def resource_from_claims(_claims), do: {:error, :invalid_auth}
end
