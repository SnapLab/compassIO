defmodule CompassIO.Api.SvgView do
  use CompassIO.Web, :view

  def render("show.json", %{cave: cave}) do
    %{
      cave:
        %{
            id: cave.id,
            name: cave.name,
            svg_canvas: [cave.svg_canvas_x, cave.svg_canvas_y],
            surveys: Enum.map(cave.surveys, &render_survey(&1))
        }
     }
  end

  def render_survey(survey) do
    %{
      key: survey.prefix,
      svg_polyline_points: survey.svg_polyline_points
    }
  end
end

