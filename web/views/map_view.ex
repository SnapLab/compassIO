defmodule CompassIO.MapView do
  use CompassIO.Web, :view
  alias CompassIO.Station
  alias CompassIO.Shot

  def point_to_json(station) do
    Poison.encode!(Station.point_json(station))
  end

  def point_xy(station) do
    [1,3]
  end

  def station_at(stations, station_name) do
    Enum.find(stations, &match?(%{name: station_name}, &1))
  end
end
