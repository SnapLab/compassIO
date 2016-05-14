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

  test "changeset is invalid if name is already taken" do
    %Cave{}
    |> Cave.changeset(@valid_attrs)
    |> CompassIO.Repo.insert!

    cave2 =
      %Cave{}
      |> Cave.changeset(@valid_attrs)

    assert {:error, changeset} = CompassIO.Repo.insert(cave2)
    {msg,_} = changeset.errors[:name]
    assert  msg == "has already been taken"
  end
end

