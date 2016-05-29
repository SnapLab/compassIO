defmodule CompassIO.PointBuilder do
  def destination(origin, distance, bearing) do
    %Geo.Point{coordinates: {origin_x, origin_y}, srid: srid} = origin
    radians = Maths.to_radians(bearing)

    %Geo.Point{coordinates: {
        origin_x + (distance * :math.cos(radians)),
        origin_y + (distance * :math.sin(radians))},
      srid: srid}
  end

  def point_zero do
    %Geo.Point{coordinates: {0, 0}}
  end
end
