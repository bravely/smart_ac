defmodule SmartAcWeb.PageController do
  use SmartAcWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
