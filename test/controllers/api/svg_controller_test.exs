defmodule CompassIO.Api.SvgControllerTest do
  use CompassIO.ConnCase

  alias CompassIO.Cave
  @valid_attrs %{name: "some content"}
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "shows chosen resource", %{conn: conn} do
    cave = Repo.insert! %Cave{name: "foo"}
    conn = get conn, api_svg_path(conn, :show, cave)
    assert json_response(conn, 200) ==
      %{"cave" =>
        %{
          "id" => cave.id,
          "name" => "foo",
          "surveys" => [],
          "svg_canvas" => [nil, nil],
          "stations" => []
        }
      }
  end

  test "does not show resource and instead throw error when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, api_svg_path(conn, :show, -1)
    end
  end
end
