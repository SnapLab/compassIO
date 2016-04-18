defmodule CompassIO.CaveTest do
  use CompassIO.ModelCase

  alias CompassIO.Cave

  @valid_attrs %{name: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Cave.changeset(%Cave{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Cave.changeset(%Cave{}, @invalid_attrs)
    refute changeset.valid?
  end
end
