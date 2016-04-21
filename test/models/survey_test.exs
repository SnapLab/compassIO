defmodule CompassIO.SurveyTest do
  use CompassIO.ModelCase

  alias CompassIO.Survey

  @valid_attrs %{comment: "some content", name: "some content", prefix: "some content", survey_date: "2010-04-17", team: "some content", tie_in: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Survey.changeset(%Survey{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Survey.changeset(%Survey{}, @invalid_attrs)
    refute changeset.valid?
  end
end
