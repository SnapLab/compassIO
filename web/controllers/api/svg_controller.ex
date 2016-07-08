defmodule CompassIO.Api.SvgController do
  use CompassIO.Web, :controller

  alias CompassIO.Cave
  alias CompassIO.Survey
  alias CompassIO.Shot
  alias CompassIO.Station

  def show(conn, %{"id" => id}) do
    cave =
      Repo.get!(Cave, id)
    surveys =
      Repo.all(from s in Survey, where: s.cave_id == ^cave.id, order_by: s.id)
      |> Repo.preload(shots: from(s in Shot, order_by: s.id))

    stations =
      Repo.all(from s in Station, where: s.cave_id == ^cave.id, order_by: s.name)

    render(conn, "show.json", cave: cave, surveys: surveys, stations: stations)
  end
end
