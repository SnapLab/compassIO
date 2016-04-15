defmodule CompassIO.DatFileTest do
  use ExUnit.Case
  doctest CompassIO
  alias CompassIO.DatFile

  test "reading the cave data from a .dat file" do
    cave = DatFile.reader("test/support/Linea\ Dorada.dat")
    assert cave.name == "Linea Dorada"

    survey = List.first(cave.surveys)
    assert survey.name == "Foo"
    assert survey.survey_date == "2016-03-05"
    assert Regex.match?(~r/Taking a shot from/, survey.comment)

    assert Enum.count(cave.surveys) == 6
  end
end
