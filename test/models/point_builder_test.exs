defmodule CompassIO.PointBuilderTest do
  use ExUnit.Case
  use CompassIO.ModelCase

  alias CompassIO.PointBuilder

  doctest CompassIO

  test "it has a point zero" do
    assert PointBuilder.point_zero == %Geo.Point{coordinates: {0, 0}}
  end

  test "it returns a destination from origin, distance and bearing" do
    new_point = PointBuilder.destination(PointBuilder.point_zero, 20, 45.0)
    assert new_point == %Geo.Point{coordinates: {14.142135623730951, 14.14213562373095}}
  end
end
