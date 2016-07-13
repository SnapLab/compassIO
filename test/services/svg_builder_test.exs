defmodule CompassIO.SvgBuilderTest do
  use ExUnit.Case
  use CompassIO.ModelCase

  alias CompassIO.Cave
  alias CompassIO.Repo
  alias CompassIO.Station
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

  test "setting the canvas#svg_canvas" do
    cave = SvgBuilder.run(cave)
    assert cave.svg_canvas_x == 142.34522816713937
    assert cave.svg_canvas_y == 275.0026826501509
  end

  test "setting the station#svg_point" do
    cave = SvgBuilder.run(cave)
    station = Repo.get_by(Station, %{name: "LIPRI14"})
    assert station.svg_point ==  "170.01847318675223,357.21551001559226"
  end

  test "setting the survey#svg_polyline_points" do
    cave = SvgBuilder.run(cave) |> Repo.preload(:surveys)
    assert List.first(cave.surveys).svg_polyline_points ==  svg_polyline_points
  end

  def svg_polyline_points do
    "0.0,350.39685021449094 31.198596610955065,376.57558112399204 29.67734757746487,393.96353714231043 48.58625402844399,393.96353714231043 92.69138832100406,384.5887014450892 100.88572111680102,400.0 122.14620800576203,390.5342213734085 168.61782609883502,373.61993564934323"
  end
end
