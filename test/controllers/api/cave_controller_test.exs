defmodule CompassIO.Api.CaveControllerTest do
  use CompassIO.ConnCase

  alias CompassIO.Cave
  @valid_attrs %{name: "some content"}
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, api_cave_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    cave = Repo.insert! %Cave{}
    conn = get conn, api_cave_path(conn, :show, cave)
    assert json_response(conn, 200)["data"] == %{"id" => cave.id,
      "name" => cave.name}
  end

  test "does not show resource and instead throw error when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, api_cave_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, api_cave_path(conn, :create), cave: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(Cave, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, api_cave_path(conn, :create), cave: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    cave = Repo.insert! %Cave{}
    conn = put conn, api_cave_path(conn, :update, cave), cave: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(Cave, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    cave = Repo.insert! %Cave{}
    conn = put conn, api_cave_path(conn, :update, cave), cave: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    cave = Repo.insert! %Cave{}
    conn = delete conn, api_cave_path(conn, :delete, cave)
    assert response(conn, 204)
    refute Repo.get(Cave, cave.id)
  end
end
