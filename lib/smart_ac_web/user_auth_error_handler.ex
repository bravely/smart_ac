defmodule SmartAcWeb.UserAuthErrorHandler do
  use SmartAcWeb, :controller

  def auth_error(conn, {:unauthenticated, _reason}, _opts) do
    conn
    |> put_flash(:info, "You must log in to proceed")
    |> redirect(to: session_path(conn, :new))
  end
  def auth_error(conn, {type, _reason}, _opts) do
    send_resp(conn, 401, to_string(type))
  end
end
