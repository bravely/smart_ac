defmodule SmartAcWeb.AdminControllerTest do
  use SmartAcWeb.ConnCase

  test "GET /admin", %{conn: conn} do
    conn = get conn, "/admin"

    assert html_response(conn, 200) =~ "Admin List"
  end
end
