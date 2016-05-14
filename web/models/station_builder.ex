defmodule CompassIO.StationBuilder do
  alias CompassIO.Repo
  alias CompassIO.Cave
  alias CompassIO.Survey
  alias CompassIO.Station


  def build(cave) do
    cave =
      Repo.get!(Cave, cave.id)
      |> Repo.preload(:surveys)
      |> Repo.preload(surveys: :shots)

    Enum.map(cave.surveys, &build_stations_and_tie_in(cave, &1))
    cave
  end

  defp build_stations_and_tie_in(cave, survey) do
    tie_in =
      if to_string(survey.tie_in) == "" do
        Repo.insert!(%Station{name: cave.station_start, depth: 0.0, survey_id: survey.id})
      else
        Repo.get_by(Station, name: survey.tie_in)
      end

    build_stations(survey.shots, survey, tie_in)
  end

  defp build_stations([], survey, _last_station) do
    []
  end

  defp build_stations([head|tail], survey, last_station) do
    station = Repo.insert!(
      %Station{
        name: head.station_to,
        depth: last_station.depth + head.depth_change,
        survey_id: survey.id
        })

    build_stations(tail, survey, station)
  end
end
