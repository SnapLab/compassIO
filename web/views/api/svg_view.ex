defmodule CompassIO.Api.SvgView do
  use CompassIO.Web, :view

  def render("show.json", %{cave: cave, surveys: surveys, stations: stations}) do
    %{
      cave:
        %{
            id: cave.id,
            name: cave.name,
            svg_canvas: [cave.svg_canvas_x, cave.svg_canvas_y],
            surveys: Enum.map(surveys, &render_survey(&1)),
            stations: Enum.map(stations, &render_station(&1))
        }
     }
  end

  def render_survey(survey) do
    %{
      id: survey.id,
      name: survey.name,
      team: survey.team,
      comment: survey.comment,
      tie_in: survey.tie_in,
      prefix: survey.prefix,
      shots: Enum.map(survey.shots, &render_shot(&1))
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

  def render_shot(shot) do
    %{
      id: shot.id,
      station_from: shot.station_from,
      station_to: shot.station_to,
      depth_change: shot.depth_change,
      inclination: shot.inclination,
      azimuth: shot.azimuth,
      distance: shot.distance,
      flags: shot.flags,
      svg_station_from: shot.svg_station_from,
      svg_station_to: shot.svg_station_to
    }
  end
end
