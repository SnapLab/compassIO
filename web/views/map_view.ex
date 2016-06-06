defmodule CompassIO.MapView do
  use CompassIO.Web, :view
  alias CompassIO.Station
  alias CompassIO.Shot

  def point_to_json(station) do
    Poison.encode!(Station.point_json(station))
  end

  def point_xy(station) do
    station.point.coordinates
    |> Tuple.to_list
    |> Enum.join(",")
  end

  def station_at(stations, station_name) do
    stations[String.to_atom(station_name)]
  end
end
