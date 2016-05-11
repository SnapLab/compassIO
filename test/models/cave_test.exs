defmodule CompassIO.CaveTest do
  use CompassIO.ModelCase

  alias CompassIO.Cave

  @valid_attrs %{name: "some content"}
  @invalid_attrs %{}
  @geo_point %Geo.Point{coordinates: {30, -90}, srid: 4326}

  test "changeset with valid attributes" do
    changeset = Cave.changeset(%Cave{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Cave.changeset(%Cave{}, @invalid_attrs)
    refute changeset.valid?
  end

  test "adding a geo start_point" do
    cave = CompassIO.Repo.insert!(
              %CompassIO.Cave{name: "some content", start_point: @geo_point})

    assert cave.start_point == @geo_point
  end
end

