defmodule SmartAcWeb.AdminControllerTest do
  use SmartAcWeb.ConnCase

  alias SmartAc.Accounts

  test "GET /admin", %{conn: conn} do
    Accounts.create_user(%{email: "first@example.com", password: "password"})
    Accounts.create_user(%{email: "second@example.com", password: "password"})
    conn = get conn, "/admin"

    assert body = html_response(conn, 200)
    assert body =~ "Admin List"
    assert body =~ "first@example.com"
    assert body =~ "second@example.com"
  end

  test "PUT /admin/:id", %{conn: conn} do
    {:ok, user} = Accounts.create_user(%{email: "admin@example.com", password: "password"})

    conn = put conn, "/admin/#{user.id}", %{"user" => %{"enabled" => "false"}}
    updated_user = Accounts.get_user!(user.id)

    assert html_response(conn, 302)
    assert updated_user.enabled == false
  end
end
