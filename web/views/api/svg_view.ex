defmodule CompassIO.Api.SvgView do
  use CompassIO.Web, :view

  def render("show.json", %{cave: cave, stations: stations}) do
    %{
      cave:
        %{
            id: cave.id,
            name: cave.name,
            svg_canvas: [cave.svg_canvas_x, cave.svg_canvas_y],
            surveys: Enum.map(cave.surveys, &render_survey(&1)),
            stations: Enum.map(stations, &render_station(&1))
        }
     }
  end

  def render_survey(survey) do
    %{
      id: survey.id,
      key: survey.prefix,
      svg_polyline_points: survey.svg_polyline_points
    }
  end

  def render_station(station) do
    %{
      id: station.id,
      name: station.name,
      depth: station.depth,
      entrance_distance: station.entrance_distance,
      svg_point: station.svg_point
    }
  end
end
