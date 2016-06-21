defmodule CompassIO.Browser.CaveControllerTest do
  use CompassIO.ConnCase

  alias CompassIO.Cave
  @valid_attrs %{name: "some content"}
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, cave_path(conn, :index)
    assert html_response(conn, 200) #=~ "Listing caves"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, cave_path(conn, :new)
    assert html_response(conn, 200)# =~ "New cave"
  end

  test "creates resource and redirects to the cave", %{conn: conn} do
    conn = post conn, cave_path(conn, :create), cave: @valid_attrs
    assert Regex.scan(~r/\/survey\//, redirected_to(conn))
    assert Repo.get_by(Cave, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, cave_path(conn, :create), cave: @invalid_attrs
    assert html_response(conn, 200)# =~ "New cave"
  end

  test "shows chosen resource", %{conn: conn} do
    cave = Repo.insert! %Cave{}
    conn = get conn, cave_path(conn, :show, cave)
    assert html_response(conn, 200)# =~ "Show cave"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, cave_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    cave = Repo.insert! %Cave{}
    conn = get conn, cave_path(conn, :edit, cave)
    assert html_response(conn, 200) =~ "Edit cave"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    cave = Repo.insert! %Cave{}
    conn = put conn, cave_path(conn, :update, cave), cave: @valid_attrs
    assert redirected_to(conn) == cave_path(conn, :show, cave)
    assert Repo.get_by(Cave, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    cave = Repo.insert! %Cave{}
    conn = put conn, cave_path(conn, :update, cave), cave: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit cave"
  end

  test "deletes chosen resource", %{conn: conn} do
    cave = Repo.insert! %Cave{}
    conn = delete conn, cave_path(conn, :delete, cave)
    assert redirected_to(conn) == cave_path(conn, :index)
    refute Repo.get(Cave, cave.id)
  end
end
