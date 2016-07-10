defmodule CompassIO.SurveyTest do
  use CompassIO.ModelCase

  alias CompassIO.Survey
  alias CompassIO.Shot

  @valid_attrs %{cave_id: 1, comment: "some content", name: "some content", prefix: "some content", survey_date: "2010-04-17", team: "some content", tie_in: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Survey.changeset(%Survey{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Survey.changeset(%Survey{}, @invalid_attrs)
    refute changeset.valid?
  end

  def survey_a do
    %Survey{
      shots: [
        %Shot{ station_from: "XYZ1", station_to: "ABC1" },
        %Shot{ station_from: "ABC1", station_to: "ABC2" },
        %Shot{ station_from: "ABC2", station_to: "ABC3" },
        %Shot{ station_from: "ABC3", station_to: "ABC4" }
      ]
    }
  end

  test "survey A has the expected station_names" do
    assert Survey.station_names(survey_a) == ["XYZ1", "ABC1","ABC2", "ABC3", "ABC4"]
  end
end
