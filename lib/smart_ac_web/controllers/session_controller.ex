defmodule SmartAcWeb.SessionController do
  use SmartAcWeb, :controller

  alias SmartAc.Accounts

  def new(conn, _params) do
    render(conn, "new.html")
  end

  def create(conn, %{"login" => %{"email" => email, "password" => password}}) do
    with %Accounts.User{} = user_with_email <- Accounts.find_user_by_email(email),
      {:ok, user} = Comeonin.Argon2.check_pass(user_with_email, password) do

      conn
      |> SmartAcWeb.Guardian.Plug.sign_in(user)
      |> redirect(to: "/")
    else
      _err ->
        conn
        |> put_flash(:error, "Invalid login")
        |> render("new.html", email: email, password: password)
    end
  end

  def delete(conn, _params) do
    conn
    |> SmartAcWeb.Guardian.Plug.sign_out
    |> redirect(to: session_path(conn, :new))
  end
end
