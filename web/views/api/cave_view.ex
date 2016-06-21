defmodule CompassIO.Api.CaveView do
  use CompassIO.Web, :view

  def render("index.json", %{caves: caves}) do
    %{data: render_many(caves, CompassIO.Api.CaveView, "cave.json")}
  end

  def render("show.json", %{cave: cave}) do
    %{data: render_one(cave, CompassIO.Api.CaveView, "cave.json")}
  end

  def render("cave.json", %{cave: cave}) do
    %{id: cave.id,
      name: cave.name}
  end
end
