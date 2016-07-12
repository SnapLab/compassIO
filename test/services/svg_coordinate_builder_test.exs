defmodule CompassIO.SvgCoordinateBuilderTest do
  use ExUnit.Case
  use CompassIO.ModelCase

  alias CompassIO.SvgCoordinateBuilder
  alias CompassIO.Cave
  alias CompassIO.Station

  doctest CompassIO

  def cave do
    %Cave{ svg_canvas_x: 400, svg_canvas_y: 450 }
  end

  def stations do
    [
      %Station{ name: "ABC1", point: %Geo.Point{coordinates: {100, 200}}},
      %Station{ name: "ABC2", point: %Geo.Point{coordinates: {210, 300}}},
      %Station{ name: "ABC3", point: %Geo.Point{coordinates: {250, 290}}}
    ]
  end

  test "builds a set of svg coordinates" do
    svg_coords = SvgCoordinateBuilder.build("ABC2", cave, stations)
    assert svg_coords == "88.88888888888889,302.22222222222223"
  end
end
