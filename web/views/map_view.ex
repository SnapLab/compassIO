defmodule CompassIO.MapView do
  use CompassIO.Web, :view
  alias CompassIO.Station
  alias CompassIO.Shot

  def point_to_json(station) do
    Poison.encode!(Station.point_json(station))
  end

  def point_xy(stations, station_name) do
    station = stations[String.to_atom(station_name)]
    if station == nil do
      "0,0"
    else
      station.point.coordinates
      |> Tuple.to_list
      |> Enum.join(",")
    end
  end

  def survey_xy(stations, survey) do
    Enum.map(survey.shots, &(
       "[#{ point_xy(stations, &1.station_to) }]"
    ))
    |> List.insert_at(0, "[#{ point_xy(stations, survey.tie_in) }]")
    |> Enum.join(",")
  end
end
