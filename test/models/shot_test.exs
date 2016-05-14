defmodule CompassIO.ShotTest do
  use CompassIO.ModelCase

  alias CompassIO.Shot

  @valid_attrs %{survey_id: 1, station_from: "some content", station_to: "some content", depth_change: 0.0, azimuth: 100, distance: 1.2}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Shot.changeset(%Shot{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Shot.changeset(%Shot{}, @invalid_attrs)
    refute changeset.valid?
  end
end
