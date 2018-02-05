defmodule SmartAcWeb.AirConditionerController do
  use SmartAcWeb, :controller

  alias SmartAc.Devices

  def create(conn, params) do
    case Devices.create_air_conditioner(params) do
      {:ok, %Devices.AirConditioner{} = air_conditioner} ->
        {:ok, token, _claims} = SmartAcWeb.Guardian.encode_and_sign(air_conditioner)
        conn
        |> put_status(201)
        |> render("create.json", air_conditioner_token: token)
      {:error, %Ecto.Changeset{} = changeset} ->
        # FIXME
        conn
        |> put_status(400)
        |> render("error.json", changeset: changeset)
    end
  end
end
