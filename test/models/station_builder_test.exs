defmodule CompassIO.StationBuilderTest do
  use ExUnit.Case
  use CompassIO.ModelCase

  alias CompassIO.StationBuilder

  doctest CompassIO

  def insert_cave do
    CompassIO.Repo.insert!(
      CompassIO.DatFile.Parser.parse("test/support/Linea\ Dorada.dat")
     )
  end

  def last_station(cave) do
    survey =
      CompassIO.Repo.get_by(CompassIO.Survey, name: "Foo")
      |> Repo.preload(stations: (from s in CompassIO.Station, order_by: s.id))

    List.last(survey.stations)
  end

  test "it build stations with the correct depth" do
    cave = insert_cave
    StationBuilder.build(cave)
    station = last_station(cave)
    assert station.depth == -21.0
  end

  test "it build stations with the correct name" do
    cave = insert_cave
    StationBuilder.build(cave)
    station = last_station(cave)
    assert last_station(cave).name == "LIFOO8"
  end

  test "it handles updates (for now) by deleting the existing stations)" do
    cave = insert_cave
    StationBuilder.build(cave)
    StationBuilder.build(cave)
    station = last_station(cave)
    assert station.depth == -21.0
  end
end
