defmodule CompassIO.SurveyController do
  use CompassIO.Web, :controller

  alias CompassIO.Survey
  alias CompassIO.Cave

  plug :scrub_params, "survey" when action in [:create, :update]
  plug :assign_cave

  def index(conn, _params) do
    surveys = Repo.all(Survey)
    render(conn, "index.html", surveys: surveys)
  end

  def new(conn, _params) do
    changeset = Survey.changeset(%Survey{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"survey" => survey_params}) do
    survey_params = Map.merge(survey_params, %{"cave_id" => conn.assigns.cave.id})
    changeset = Survey.changeset(%Survey{}, survey_params)

    case Repo.insert(changeset) do
      {:ok, survey} ->
        conn
        |> put_flash(:info, "Survey created successfully.")
        |> redirect(to: cave_survey_path(conn, :show, conn.assigns.cave, survey))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    survey = Repo.get!(Survey, id) |> Repo.preload(:shots)
    render(conn, "show.html", survey: survey)
  end

  def edit(conn, %{"id" => id}) do
    survey = Repo.get!(Survey, id) |> Repo.preload(:shots)
    changeset = Survey.changeset(survey)
    render(conn, "edit.html", survey: survey, changeset: changeset)
  end

  def update(conn, %{"id" => id, "survey" => survey_params}) do
    survey = Repo.get!(Survey, id) |> Repo.preload(:shots)
    changeset = Survey.changeset(survey, survey_params)

    case Repo.update(changeset) do
      {:ok, survey} ->
        conn
        |> put_flash(:info, "Survey updated successfully.")
        |> redirect(to: cave_survey_path(conn, :show, 1, survey))
      {:error, changeset} ->
        render(conn, "edit.html", survey: survey, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    survey = Repo.get!(Survey, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(survey)

    conn
    |> put_flash(:info, "Survey deleted successfully.")
    |> redirect(to: cave_survey_path(conn, :index, 1))
  end

  defp assign_cave(conn, _opts) do
    case conn.params do
      %{"cave_id" => cave_id} ->
        cave = Repo.get(Cave, cave_id)
        assign(conn, :cave, cave)
      _ ->
        conn
    end
  end
end
