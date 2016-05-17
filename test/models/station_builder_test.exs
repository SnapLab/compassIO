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

  def last_station do
    survey =
      CompassIO.Repo.get_by(CompassIO.Survey, name: "Principal")
      |> Repo.preload(stations: (from s in CompassIO.Station, order_by: s.id))

    List.last(survey.stations)
  end

  test "it build stations with the correct depth" do
    StationBuilder.build(cave)
    assert last_station.depth == -12.0
  end

  test "it build stations with the correct name" do
    StationBuilder.build(cave)
    assert last_station.name == "LIPRI14"
  end

  test "it build stations with the correct entrance distance" do
    StationBuilder.build(cave)
    assert last_station.entrance_distance == 210.0
  end

  test "it is successful when the StationBuilder runs twice" do
    this_cave = cave
    StationBuilder.build(this_cave)
    assert last_station.depth == -12.0
    StationBuilder.build(this_cave)
    assert last_station.depth == -12.0
  end

  test "it sorts out the weird Regina stations"
end
