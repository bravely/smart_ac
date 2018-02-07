defmodule SmartAcWeb.AirConditionerController do
  use SmartAcWeb, :controller

  alias SmartAc.Devices

  # HTML-only
  def index(conn, _params) do
    render(conn, "index.html", air_conditioners: Devices.list_air_conditioners_ordered())
  end

  def show(conn, %{"id" => ac_id}) do
    air_conditioner = Devices.get_air_conditioner!(ac_id)
    status_reports = Devices.list_status_reports_for_air_conditioner(air_conditioner)
    render(conn, "show.html", air_conditioner: air_conditioner, status_reports: status_reports)
  end

  # JSON-only
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

  def search(conn, %{"query" => serial}) do
    case Devices.find_air_conditioner_by_serial(serial) do
      %Devices.AirConditioner{id: ac_id} ->
        redirect(conn, to: air_conditioner_path(conn, :show, ac_id))
      _other ->
        conn
        |> put_flash(:error, "No Air Conditioner with that serial found")
        |> redirect(to: air_conditioner_path(conn, :index))
    end
  end

  def resolve(conn, %{"id" => ac_id}) do
    {:ok, air_conditioner} =
      ac_id
      |> Devices.get_air_conditioner!
      |> Devices.update_air_conditioner_to_safe

    redirect(conn, to: air_conditioner_path(conn, :show, air_conditioner.id))
  end
end
