defmodule CompassIO.ParserTest do
  use ExUnit.Case
  use CompassIO.ModelCase

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

  test "it produces a valid CompassIO.Cave" do
    assert is_a_compassIO_cave?(cave)
  end

  test "it timestamps the name if it already exists" do
    CompassIO.Repo.insert!(%CompassIO.Cave{ name: "Linea Dorada"})
    assert Regex.match?(~r/Linea Dorada-20.*/, cave.name)
  end

  def is_a_compassIO_cave?(%CompassIO.Cave{}) do
    true
  end

  def is_a_compassIO_cave?(_) do
    false
  end
end
