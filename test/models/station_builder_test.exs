defmodule CompassIO.StationBuilderTest do
  use ExUnit.Case
  use CompassIO.ModelCase

  alias CompassIO.StationBuilder

  doctest CompassIO

  def cave do
    CompassIO.Repo.insert!(
      CompassIO.DatFile.Parser.parse("test/support/Linea\ Dorada.dat")
     )
  end

  test "it build stations with the correct depth" do
    surveys = StationBuilder.build(cave).surveys
    last_station = List.last(List.last(surveys).stations)
    assert last_station.depth == -19.0
  end

  test "it handles updates"
end
