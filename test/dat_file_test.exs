defmodule CompassIO.DatFileTest do
  use ExUnit.Case
  doctest CompassIO
  alias CompassIO.DatFile

  def cave do
    DatFile.reader("test/support/Linea\ Dorada.dat")
  end

  def first_survey do
    List.first(cave.surveys)
  end

  test "read the cave name" do
    assert cave.name == "Linea Dorada"
  end

  test "read the first survey name" do
    assert first_survey.name == "Foo"
  end

  test "read the first survey date" do
    assert first_survey.survey_date == "2016-03-05"
  end

  test "read the first survey comment" do
    assert Regex.match?(~r/Taking a shot from/, first_survey.comment)
  end

  test "read the first survey team" do
    # assert first_survey.team == "Toby Privett"
  end

  test "read the number of surveys" do
    assert Enum.count(cave.surveys) == 6
  end
end
