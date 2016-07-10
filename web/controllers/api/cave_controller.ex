defmodule CompassIO.Api.CaveController do
  use CompassIO.Web, :controller

  alias CompassIO.Cave
  alias CompassIO.Survey
  alias CompassIO.Shot
  alias CompassIO.Station

  plug :scrub_params, "cave" when action in [:create, :update]

  def index(conn, _params) do
    caves = Repo.all(Cave)
    render(conn, "index.json", caves: caves)
  end

  def create(conn, %{"cave" => cave_params}) do
    changeset = Cave.changeset(%Cave{}, cave_params)

    case MapBuilder.create(changeset) do
      {:ok, cave} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", cave_path(conn, :show, cave))
        |> render("show.json", cave: cave, surveys: [], stations: [])
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(CompassIO.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    cave =
      Repo.get!(Cave, id)
    surveys =
      Repo.all(from s in Survey, where: s.cave_id == ^cave.id, order_by: s.id)
      |> Repo.preload(shots: from(s in Shot, order_by: s.id))

    stations =
      Repo.all(from s in Station, where: s.cave_id == ^cave.id, order_by: s.name)
      |> Enum.map(&{String.to_atom(&1.name),  &1})

    render(conn, "show.json", cave: cave, surveys: surveys, stations: stations)
  end

  def update(conn, %{"id" => id, "cave" => cave_params}) do
    cave =
      Repo.get!(Cave, id)
      |> Repo.preload(:surveys)
    changeset = Cave.changeset(cave, cave_params)

    case MapBuilder.update(changeset) do
      {:ok, cave} ->
        render(conn, "show.json", cave: cave, surveys: [], stations: [])
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(CompassIO.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    cave = Repo.get!(Cave, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(cave)

    send_resp(conn, :no_content, "")
  end
end
