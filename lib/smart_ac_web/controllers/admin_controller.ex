defmodule SmartAcWeb.AdminController do
  use SmartAcWeb, :controller

  alias SmartAc.Accounts

  def index(conn, _params) do
    user_changesets =
      Accounts.list_users()
      |> Enum.map(&Accounts.change_user/1)

    render(conn, "index.html", user_changesets: user_changesets)
  end

  def update(conn, %{"id" => user_id, "user" => user_params}) do
    user = Accounts.get_user!(user_id)
    case Accounts.update_user(user, user_params) do
      {:ok, updated_user} ->
        enabled_status =
          if updated_user.enabled do
            "enabled"
          else
            "disabled"
          end
        conn
        |> put_flash(:info, "#{updated_user.email} #{enabled_status}.")
        |> redirect(to: admin_path(conn, :index))
      {:error, changeset} ->
        conn
        |> put_flash(:error, "Could not update #{changeset.data.email}, internal server error.")
        |> redirect(to: admin_path(conn, :index))
    end
  end

  def new_password_reset(conn, _params) do
    render(conn, "new_password_reset.html")
  end

  def password_reset(conn, %{"email" => email}) do
    Accounts.update_with_access_token(email)

    conn
    |> put_flash(:info, "A password reset email has been sent to #{email}.")
    |> render("new_password_reset.html")
  end

  def edit_password(conn, %{"access_token" => access_token}) do
    case Accounts.find_user_by_access_token(access_token) do
      %Accounts.User{} ->
        render(conn, "edit_password.html", access_token: access_token)
      nil ->
        conn
        |> put_flash(:error, "No user found with given access token")
        |> render("new_password_reset.html")
    end
  end

  def update_password(conn, %{"access_token" => access_token, "password" => password}) do
    case Accounts.update_user_password_via_access_token(access_token, password) do
      {:ok, _user} ->
        conn
        |> put_flash(:info, "Password successfully updated, please log in.")
        |> redirect(to: session_path(conn, :new))
      {:error, :not_found} ->
        conn
        |> put_flash(:error, "No user found with given access token")
        |> render("new_password_reset.html")
      {:error, _changeset} ->
        conn
        |> put_flash(:error, "There was an error updating your password, try again.")
        |> render("new_password_reset.html")
    end
  end
end
