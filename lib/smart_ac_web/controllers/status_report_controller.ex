defmodule SmartAcWeb.StatusReportController do
  use SmartAcWeb, :controller

  alias SmartAc.Devices

  def bulk(conn, %{"status_reports" => status_reports}) do
    air_conditioner = SmartAcWeb.Guardian.Plug.current_resource(conn, key: :authorization)
    
    case Devices.bulk_create_status_reports(air_conditioner, status_reports) do
      {:ok, reports_created} ->
        conn
        |> put_status(201)
        |> render("bulk.json", number_created: length(reports_created))
      {:error, reason} ->
        conn
        |> put_status(400)
        |> render("error.json", reason: reason)
    end
  end
end
