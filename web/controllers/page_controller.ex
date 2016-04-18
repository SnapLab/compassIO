defmodule CompassIO.PageController do
  use CompassIO.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
