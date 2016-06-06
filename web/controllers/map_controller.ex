defmodule CompassIO.MapController do
  use CompassIO.Web, :controller

  alias CompassIO.Cave
  alias CompassIO.Survey
  alias CompassIO.Station
  alias CompassIO.StationBuilder

  plug :put_layout, "map.html"

  def show(conn, %{"id" => id}) do
    cave = Repo.get!(Cave, id)
    surveys =
      Repo.all(from s in Survey, where: s.cave_id == ^cave.id, order_by: s.id)
      |> Repo.preload(stations: from(s in Station, order_by: s.id))

    render(conn, "show.html", cave: cave, surveys: surveys)
  end
end
