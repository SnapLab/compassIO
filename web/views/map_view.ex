defmodule CompassIO.MapView do
  use CompassIO.Web, :view
  alias CompassIO.Station

  def point_to_json(station) do
    Poison.encode!(Station.point_json(station))
  end
end
