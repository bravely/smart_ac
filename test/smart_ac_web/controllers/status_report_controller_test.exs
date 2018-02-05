defmodule SmartAcWeb.StatusReportControllerTest do
  use SmartAcWeb.ConnCase

  alias SmartAc.Devices

  def air_conditioner_fixture(attrs \\ %{}) do
    {:ok, air_conditioner} =
      attrs
      |> Enum.into(%{firmware_version: "some firmware_version", registered_at: "2010-04-17 14:00:00.000000Z", serial: "some serial"})
      |> SmartAc.Devices.create_air_conditioner()

    air_conditioner
  end

  test "POST /api/status_report/bulk", %{conn: conn} do
    ac = air_conditioner_fixture()
    params = [
      %{carbon_monoxide_ppm: 1, device_health: "first", humidity: 6, temperature: 11},
      %{carbon_monoxide_ppm: 2, device_health: "second", humidity: 7, temperature: 12}
    ]

    conn =
      conn
      |> put_req_header("authorization", "Bearer #{token_for(ac)}")
      |> post("/api/status_report/bulk", %{status_reports: params})

    assert response(conn, 201)
    [first, second] = Devices.list_status_reports()

    assert first.air_conditioner_id == ac.id
    assert second.air_conditioner_id == ac.id
  end
end
