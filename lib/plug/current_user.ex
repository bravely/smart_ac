defmodule SmartAcWeb.Plug.CurrentUser do
  import Plug.Conn

  alias SmartAc.Accounts.User

  def init(opts), do: opts

  def call(conn, _opts) do
    case Guardian.Plug.current_resource(conn) do
      %User{enabled: true} = current_user ->
        assign(conn, :current_user, current_user)
      _other ->
        SmartAcWeb.Guardian.Plug.sign_out(conn)
    end
  end
end
