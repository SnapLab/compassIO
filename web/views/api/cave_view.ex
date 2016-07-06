defmodule CompassIO.Api.CaveView do
  use CompassIO.Web, :view

  def render("index.json", %{caves: caves}) do
    render_many(caves, CompassIO.Api.CaveView, "cave.json")
  end

  def render("show.json", %{cave: cave, surveys: surveys, stations: stations}) do
    %{
      cave:
        %{
            id: cave.id,
            name: cave.name,
            surveys: Enum.map(surveys, &render_survey(&1, stations)),
            svg: svg(surveys, stations)
        }
     }
  end

  def render("cave.json", %{cave: cave}) do
    %{
       id: cave.id,
       name: cave.name
    }
  end

  def render("station.json", %{station: station}) do
    %{
       name: station.name,
       depth: station.depth,
       point: Geo.JSON.encode(station.point),
       entrance_distance: station.entrance_distance
    }
  end

  def svg(surveys, stations) do
    "<svg>
      <g transform=\"translate(450,250) rotate(-90)\">
      #{ svg_polylines(surveys, stations) }
      <g>
    </svg>"
  end

  def svg_polylines(surveys, stations) do
    surveys
    |> Enum.map(&svg_polyline(&1, stations))
  end

  def svg_polyline(survey, stations) do
    "<polyline points=\"#{
      Enum.join(svg_points(survey, stations), " ")
    }\" />"
  end

  def svg_points(survey, stations) do
    survey.shots
    |> Enum.map(&svg_point(&1.station_to, stations))
    |> List.insert_at(0, svg_point(survey.tie_in, stations))
  end

  def svg_point(station, stations) do
    if String.strip(station) == "" do
      "0,0"
    else
      stations[String.to_atom(station)].point.coordinates
      |> Tuple.to_list
      |> Enum.join(",")
    end
  end

  def render_survey(survey, stations) do
    %{
      name: survey.name,
      comment: survey.comment,
      survey_date: survey.survey_date,
      team: survey.team,
      tie_in: survey.tie_in,
      prefix: survey.prefix,
      shots: Enum.map(survey.shots, &render_shot(&1, stations))
    }
  end

  def render_shot(shot, stations) do
    %{
      station_from: render_one(stations[String.to_atom(shot.station_from)], CompassIO.Api.CaveView, "station.json", as: :station),
      station_to: render_one(stations[String.to_atom(shot.station_to)], CompassIO.Api.CaveView, "station.json", as: :station),
      azimuth: shot.azimuth,
      distance: shot.distance,
      flags: shot.flags
    }
  end
end
