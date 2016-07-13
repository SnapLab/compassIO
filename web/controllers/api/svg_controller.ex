defmodule CompassIO.Api.SvgController do
  use CompassIO.Web, :controller

  alias CompassIO.Cave
  alias CompassIO.Station

  def show(conn, %{"id" => id}) do
    cave =
      Repo.get!(Cave, id)
      |> Repo.preload(:surveys)

    stations = Repo.all(from s in Station,
                        where: s.cave_id == ^cave.id,
                        order_by: s.name)

    render(conn, "show.json", cave: cave, stations: stations)
  end
end
