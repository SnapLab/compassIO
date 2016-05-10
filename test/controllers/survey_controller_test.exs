defmodule CompassIO.SurveyControllerTest do
  use CompassIO.ConnCase

  alias CompassIO.Survey
  import CompassIO.Factory

  @valid_attrs %{cave_id: 1, comment: "some content", name: "some content", prefix: "some content", survey_date: "2010-04-17", team: "some content", tie_in: "some content"}
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    cave = create(:cave)
    conn = get conn, cave_survey_path(conn, :index, cave)
    assert html_response(conn, 200) =~ cave.name
  end

  test "renders form for new resources", %{conn: conn} do
    cave = create(:cave)
    conn = get conn, cave_survey_path(conn, :new, cave)
    assert html_response(conn, 200) =~ "New survey"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    cave = create(:cave)
    conn = post conn, cave_survey_path(conn, :create, cave), survey: @valid_attrs
    survey = Repo.get_by!(Survey, @valid_attrs)
    assert redirected_to(conn) == cave_survey_path(conn, :show, cave, survey)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    cave = create(:cave)
    conn = post conn, cave_survey_path(conn, :create, cave), survey: @invalid_attrs
    assert html_response(conn, 200) =~ "New survey"
  end

  test "shows chosen resource", %{conn: conn} do
    cave = create(:cave)
    survey = Repo.insert! %Survey{}
    conn = get conn, cave_survey_path(conn, :show, cave, survey)
    assert html_response(conn, 200) =~ cave.name
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    cave = create(:cave)
    assert_error_sent 404, fn ->
      get conn, cave_survey_path(conn, :show, cave, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    cave = create(:cave)
    survey = Repo.insert! %Survey{}
    conn = get conn, cave_survey_path(conn, :edit, cave, survey)
    assert html_response(conn, 200) =~ "Edit survey"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    cave = create(:cave)
    survey = Repo.insert! %Survey{}
    conn = put conn, cave_survey_path(conn, :update, cave, survey), survey: @valid_attrs
    assert redirected_to(conn) == cave_survey_path(conn, :show, cave, survey)
    assert Repo.get_by(Survey, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    cave = create(:cave)
    survey = Repo.insert! %Survey{}
    conn = put conn, cave_survey_path(conn, :update, cave, survey), survey: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit survey"
  end

  test "deletes chosen resource", %{conn: conn} do
    cave = create(:cave)
    survey = Repo.insert! %Survey{}
    conn = delete conn, cave_survey_path(conn, :delete, cave, survey)
    assert redirected_to(conn) == cave_survey_path(conn, :index, cave)
    refute Repo.get(Survey, survey.id)
  end
end
