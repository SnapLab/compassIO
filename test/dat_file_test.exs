defmodule CompassIO.DatFileTest do
  use ExUnit.Case
  doctest CompassIO
  alias CompassIO.DatFile

  def cave do
    {:ok, cave} = DatFile.reader("test/support/Linea\ Dorada.dat")
    cave
  end

  def first_survey do
    List.first(cave.surveys)
  end

  def first_shot do
    List.first(first_survey.shots)
  end

  test "gracefully handle a bad filename" do
    {:error, msg} = DatFile.reader("not-a-file")
    assert Regex.match?(~r/File could not be opened/, msg)
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
    assert first_survey.team == "Toby Privett"
  end

  test "read the number of surveys" do
    assert Enum.count(cave.surveys) == 6
  end

  test "read the number of shots from the first survey" do
    assert Enum.count(first_survey.shots) == 7
  end

  test "read the first shot from_station" do
    assert first_shot.from_station == "LIFOO1"
  end

  test "read the first shot to_station" do
    assert first_shot.to_station == "LIFOO2"
  end

  test "read the first shot length" do
    assert first_shot.length == "16.00"
  end

  test "read the first shot bearing" do
    assert first_shot.bearing == "215.00"
  end

  test "read the first shot inclination" do
    assert first_shot.inclination == "-18.21"
  end

  test "read the first shot flags" do
    assert first_shot.flags == "PC"
  end

  test "read the first shot comment" do
    assert first_shot.comment == "This is the first station"
  end
end
