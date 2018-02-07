defmodule SmartAcWeb.AirConditionerControllerTest do
  use SmartAcWeb.ConnCase

  test "GET /air_conditioner", %{conn: conn} do
    {:ok, user} = Accounts.create_user(%{email: "first@example.com", password: "password"})
    {:ok, ac} = Devices.create_air_conditioner(%{serial: "test123", registered_at: DateTime.utc_now, firmware_version: "0.1"})

    conn =
      conn
      |> sign_in(user)
      |> get("/air_conditioner")

    assert html_response(conn, 200) =~ "Air Conditioners"
    assert html_response(conn, 200) =~ ac.serial
  end

  test "GET /air_conditioner/:id", %{conn: conn} do
    {:ok, user} = Accounts.create_user(%{email: "first@example.com", password: "password"})
    {:ok, ac} = Devices.create_air_conditioner(%{serial: "test123", registered_at: DateTime.utc_now, firmware_version: "0.1"})

    conn =
      conn
      |> sign_in(user)
      |> get("/air_conditioner/#{ac.id}")

    assert html_response(conn, 200) =~ ac.serial
  end

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

  test "GET /air_conditioner/search", %{conn: conn} do
    {:ok, user} = Accounts.create_user(%{email: "first@example.com", password: "password"})
    {:ok, ac} = Devices.create_air_conditioner(%{serial: "test123", registered_at: DateTime.utc_now, firmware_version: "0.1"})

    conn =
      conn
      |> sign_in(user)
      |> get("/air_conditioner/search?query=#{ac.serial}")

    assert redirected_to(conn) =~ "/air_conditioner/#{ac.id}"
  end
end
