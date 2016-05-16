defmodule CompassIO.StationBuilder do
  import Ecto.Query
  alias CompassIO.Repo
  alias CompassIO.Cave
  alias CompassIO.Survey
  alias CompassIO.Shot
  alias CompassIO.Station


  def build(cave) do
    cave = reset_cave_stations(cave)
    Enum.map(cave.surveys, &build_stations_and_tie_in(cave, &1))
  end

  defp reset_cave_stations(cave) do
    Repo.delete_all(CompassIO.Station, cave_id: cave.id)

    Repo.get!(Cave, cave.id)
      |> Repo.preload(surveys: [shots: (from s in CompassIO.Shot, order_by: s.id)])
  end

  defp build_stations_and_tie_in(cave, survey) do
    tie_in =
      if to_string(survey.tie_in) == "" do
        Repo.insert!(
          %Station{name: cave.station_start, depth: 0.0,
                    survey_id: survey.id, cave_id: cave.id})
      else
        Repo.get_by(Station, name: survey.tie_in, cave_id: cave.id)
      end
    build_stations(survey.shots, survey, tie_in)
  end

  defp build_stations([], survey, _last_station) do
    []
  end

  defp build_stations([head|tail], survey, last_station) do
    last_depth =
      if last_station do
        last_station.depth
      else
        0.0
      end

    station = Repo.insert!(
      %Station{
      name: head.station_to,
      depth: last_depth + head.depth_change,
      survey_id: survey.id,
      cave_id: survey.cave_id
      })

    build_stations(tail, survey, station)
  end
end
