defmodule SmartAcWeb.AirConditionerControllerTest do
  use SmartAcWeb.ConnCase

  test "POST /api/air_conditioner without errors", %{conn: conn} do
    params = %{firmware_version: "0.1.0", registered_at: "2010-04-17 14:00:00.000000Z", serial: "serial123"}

    conn = post conn, "/api/air_conditioner", params
    assert %{"token" => _token} = json_response(conn, 201)
  end

  test "POST /api/air_conditioner with error", %{conn: conn} do
    params = %{firmware_version: "0.1.0", registered_at: "2010-04-17 14:00:00.000000Z", serial: "serial123"}

    conn = post conn, "/api/air_conditioner", %{params | serial: nil}
    assert %{"serial" => ["can't be blank"]} = json_response(conn, 400)
  end
end
