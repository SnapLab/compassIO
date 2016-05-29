defmodule CompassIO.MapView do
  use CompassIO.Web, :view
  alias CompassIO.Station
  alias CompassIO.Shot

  def point_to_json(station) do
    Poison.encode!(Station.point_json(station))
  end

  def point_xy(shot) do
    # %Shot{point_x, point_y} = shot.station_from
    # "#{ point_x },#{ point_y }"
    "10,20"
  end
end
