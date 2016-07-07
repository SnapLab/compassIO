defmodule CompassIO.Api.SvgView do
  use CompassIO.Web, :view

  def render("show.json", %{cave: cave, surveys: surveys, stations: stations}) do
    %{
      cave:
        %{
            id: cave.id,
            name: cave.name,
            surveys: []
        }
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

end
