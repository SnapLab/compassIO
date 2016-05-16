defmodule CompassIO.MapController do
  use CompassIO.Web, :controller

  alias CompassIO.Cave
  alias CompassIO.StationBuilder

  def show(conn, %{"id" => id}) do
    StationBuilder.build(Repo.get!(Cave, id))
    cave =
      Repo.get!(Cave, id)
      |> Repo.preload(surveys: [stations: (from s in CompassIO.Station, order_by: s.id)])

    render(conn, "show.html", cave: cave)
  end
end
