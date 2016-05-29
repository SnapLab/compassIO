defmodule CompassIO.DatFile.SurveyTest do
  use ExUnit.Case

  alias CompassIO.DatFile.Survey
  alias CompassIO.DatFile.Shot

  def survey_a do
    %Survey{
      shots: [
        %Shot{ from_station: "XYZ1", to_station: "ABC1" }
      ]
    }
  end

  def survey_b do
    %Survey{
      shots: [
        %Shot{ from_station: "ABC1", to_station: "ABC1" }
      ]
    }
  end

  def survey_c do
    %Survey{
      shots: [
        %Shot{ from_station: "ABC2", to_station: "ABC2a" }
      ]
    }
  end

  test "survey A has a tie_in" do
    assert Survey.tie_in(survey_a) == "XYZ1"
  end

  test "survey A has the prefix" do
    assert Survey.prefix(survey_a)== "ABC"
  end

  test "survey B has no tie_in" do
    assert Survey.tie_in(survey_b) == ""
  end

  test "survey B has a prefix" do
    assert Survey.prefix(survey_b) == "ABC"
  end

  test "survey C has prefix" do
    assert Survey.prefix(survey_c) == "ABC"
  end
end
