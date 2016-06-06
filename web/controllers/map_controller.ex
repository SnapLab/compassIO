defmodule CompassIO.MapController do
  use CompassIO.Web, :controller

  alias CompassIO.Cave
  alias CompassIO.Survey
  alias CompassIO.Station
  alias CompassIO.StationBuilder
  alias CompassIO.Shot

  plug :put_layout, "map.html"

  def show(conn, %{"id" => id}) do
    cave = Repo.get!(Cave, id)
    surveys =
      Repo.all(from s in Survey, where: s.cave_id == ^cave.id, order_by: s.id)
      |> Repo.preload(shots: from(s in Shot, order_by: s.id))

    stations =
      Repo.all(from s in Station, where: s.cave_id == ^cave.id, order_by: s.name)
      |> Enum.map(&{ String.to_atom(&1.name),  &1})

    render(conn, "show.html", cave: cave, surveys: surveys, stations: stations)
  end
end
