defmodule CompassIO.SvgBuilderTest do
  use ExUnit.Case
  use CompassIO.ModelCase

  alias CompassIO.Cave
  alias CompassIO.Repo
  alias CompassIO.StationBuilder
  alias CompassIO.SvgBuilder
  doctest CompassIO

  # ensure there is a cave with some stations
  def cave do
    case Repo.get_by(Cave, %{name: "Linea Dorada"}) do
      {cave} ->
        cave
      _ ->
        Repo.insert!(CompassIO.DatFile.Parser.parse("test/support/Linea\ Dorada.dat"))
        |> StationBuilder.run
    end
  end

  test "setting the svg_canvas" do
    cave = SvgBuilder.run(cave)
    assert cave.svg_canvas_x == 142.34522816713937
    assert cave.svg_canvas_y == 275.0026826501509
  end

  test "setting the svg_polyline_points" do
    cave = SvgBuilder.run(cave) |> Repo.preload(:surveys)
    assert List.first(cave.surveys).svg_polyline_points ==  svg_polyline_points
  end

  def svg_polyline_points do
    "-4.430486529538186,-137.50134132507546 -22.428539600761283,-116.05209691774408 -34.38287597786223,-117.09796583071596 -34.38287597786223,-104.09796583071596 -27.937613562511686,-73.775390207968 -38.53298467681881,-68.14173145453731 -32.02519838760601,-53.5250041322557 -20.396513514533268,-21.575455025534808"
  end
end
