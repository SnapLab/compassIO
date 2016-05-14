defmodule CompassIO.StationTest do
  use CompassIO.ModelCase

  alias CompassIO.Station

  @valid_attrs %{survey_id: 1, name: "some content", depth: 0.0}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Station.changeset(%Station{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Station.changeset(%Station{}, @invalid_attrs)
    refute changeset.valid?
  end
end
