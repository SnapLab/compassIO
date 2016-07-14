defmodule CompassIO.Api.SvgController do
  use CompassIO.Web, :controller

  alias CompassIO.Cave
  alias CompassIO.Station
  alias CompassIO.Survey

  def show(conn, %{"id" => id}) do
    cave = Repo.get!(Cave, id)

    surveys = Repo.all(
                from survey in Survey,
                join: shot in assoc(survey, :shots),
                preload: [shots: shot],
                where: survey.cave_id == ^cave.id)

    stations = Repo.all(from s in Station,
                        where: s.cave_id == ^cave.id,
                        order_by: s.name)

    render(conn, "show.json", cave: cave, surveys: surveys, stations: stations)
  end
end
