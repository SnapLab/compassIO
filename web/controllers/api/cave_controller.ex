defmodule CompassIO.Api.CaveController do
  use CompassIO.Web, :controller

  alias CompassIO.Cave

  plug :scrub_params, "cave" when action in [:create, :update]

  def index(conn, _params) do
    caves = Repo.all(Cave)
    render(conn, "index.json", caves: caves)
  end

  def create(conn, %{"cave" => cave_params}) do
    changeset = Cave.changeset(%Cave{}, cave_params)

    case Repo.insert(changeset) do
      {:ok, cave} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", cave_path(conn, :show, cave))
        |> render("show.json", cave: cave)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(CompassIO.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    cave = Repo.get!(Cave, id)
    render(conn, "show.json", cave: cave)
  end

  def update(conn, %{"id" => id, "cave" => cave_params}) do
    cave =
      Repo.get!(Cave, id)
      |> Repo.preload(:surveys)
    changeset = Cave.changeset(cave, cave_params)

    case Repo.update(changeset) do
      {:ok, cave} ->
        render(conn, "show.json", cave: cave)
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
