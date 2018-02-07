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
end
