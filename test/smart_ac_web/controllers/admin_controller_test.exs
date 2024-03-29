defmodule SmartAcWeb.AdminControllerTest do
  use SmartAcWeb.ConnCase

  alias SmartAc.Accounts

  test "GET /admin", %{conn: conn} do
    {:ok, first} = Accounts.create_user(%{email: "first@example.com", password: "password"})
    Accounts.create_user(%{email: "second@example.com", password: "password"})
    conn =
      conn
      |> sign_in(first)
      |> get("/admin")

    assert body = html_response(conn, 200)
    assert body =~ "Admin List"
    assert body =~ "first@example.com"
    assert body =~ "second@example.com"
  end

  test "GET /admin/new", %{conn: conn} do
    {:ok, first} = Accounts.create_user(%{email: "first@example.com", password: "password"})

    conn =
      conn
      |> sign_in(first)
      |> get("/admin")

    assert html_response(conn, 200) =~ "Invite Admin"
  end

  test "POST /admin", %{conn: conn} do
    {:ok, first} = Accounts.create_user(%{email: "first@example.com", password: "password"})
    new_user_email = "test@example.com"

    conn =
      conn
      |> sign_in(first)
      |> post("/admin", %{"email" => new_user_email})


    assert html_response(conn, 302)
    assert new_user = Accounts.find_user_by_email(new_user_email)
    assert new_user.access_token
    assert_delivered_email SmartAcWeb.Email.password_reset(new_user)
  end

  test "PUT /admin/:id", %{conn: conn} do
    {:ok, user} = Accounts.create_user(%{email: "admin@example.com", password: "password"})

    conn =
      conn
      |> sign_in(user)
      |> put("/admin/#{user.id}", %{"user" => %{"enabled" => "false"}})
    updated_user = Accounts.get_user!(user.id)

    assert html_response(conn, 302)
    assert updated_user.enabled == false
  end

  test "GET /admin/password_reset/new", %{conn: conn} do
    conn = get(conn, "/admin/password_reset/new")

    assert html_response(conn, 200) =~ "Password Reset"
  end

  test "POST /admin/password_reset sets an access token and sends an email", %{conn: conn} do
    {:ok, user} = Accounts.create_user(%{email: "test@example.com", password: "password"})

    assert user.access_token == nil

    conn = post(conn, "/admin/password_reset", %{"email" => user.email})
    updated_user = Accounts.get_user!(user.id)

    assert html_response(conn, 200) =~ "Password Reset"
    assert updated_user.access_token
    assert_delivered_email SmartAcWeb.Email.password_reset(updated_user)
  end
end
