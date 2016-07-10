defmodule CompassIO.Api.SvgController do
  use CompassIO.Web, :controller

  alias CompassIO.Cave

  def show(conn, %{"id" => id}) do
    cave =
      Repo.get!(Cave, id)
      |> Repo.preload(:surveys)

    render(conn, "show.json", cave: cave)
  end
end
