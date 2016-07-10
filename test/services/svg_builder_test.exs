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
end
