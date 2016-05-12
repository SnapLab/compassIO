defmodule CompassIO.ParserTest do
  use ExUnit.Case
  doctest CompassIO

  alias CompassIO.DatFile.Parser

  def cave do
    Parser.parse("test/support/Linea\ Dorada.dat")
  end

  test "it has a name" do
    assert cave.name == "Linea Dorada"
  end

  test "it has a station where the surveying starts" do
    assert cave.station_start == "LIFOO1"
  end

  test "it has 6 surveys" do
    assert Enum.count(cave.surveys) == 6
  end

  test "the first survey has 7 shots" do
    survey = List.first(cave.surveys)
    assert Enum.count(survey.shots) == 7
  end

  test "the first survey has 21 stations" do
    survey = List.first(cave.surveys)
    assert Enum.count(survey.stations) == 8
  end

  test "the last station depth for the first survey" do
    survey = List.first(cave.surveys)
    station = List.last(survey.stations)
    assert station.name == "LIFOO8"
    assert station.depth == -21.0
  end

  test "it produces a valid CompassIO.Cave" do
    assert is_a_compassIO_cave?(cave)
  end

  def is_a_compassIO_cave?(%CompassIO.Cave{}) do
    true
  end

  def is_a_compassIO_cave?(_) do
    false
  end
end
