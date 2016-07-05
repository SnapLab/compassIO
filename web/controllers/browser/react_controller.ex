defmodule CompassIO.Browser.ReactController do
  use CompassIO.Web, :controller

  def index(conn, _params) do
    conn
    |> put_layout(false)
    |> render "index.html"
  end
end
