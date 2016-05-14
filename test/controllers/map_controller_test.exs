defmodule CompassIO.MapControllerTest do
  use CompassIO.ConnCase

  alias CompassIO.Cave
  @valid_attrs %{name: "Foo"}
  @invalid_attrs %{}

  test "shows chosen resource", %{conn: conn} do
    cave = Repo.insert! %Cave{name: "Foo"}
    conn = get conn, map_path(conn, :show, cave)
    assert html_response(conn, 200) =~ "<h2>Foo</h2>"
  end
end
