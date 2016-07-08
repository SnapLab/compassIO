defmodule CompassIO.Api.SvgView do
  use CompassIO.Web, :view

  def render("show.json", %{cave: cave, surveys: surveys, stations: stations}) do
    %{
      cave:
        %{
            id: cave.id,
            name: cave.name,
            surveys: render_surveys(surveys, stations)
        }
     }
  end

  def render_surveys(surveys, stations) do
    Enum.map(
      surveys,
        &render_survey(&1, stations, coord_spread(stations)))
  end

  def render_survey(survey, stations, coord_spread) do
    %{
      key: survey.prefix,
      points: points(survey, stations, coord_spread)
    }
  end

  def coordinates(station_atom, stations, coord_spread) do
    station_at(station_atom, stations).point.coordinates
    |> to_svg(coord_spread)
    |> Tuple.to_list
  end

  def points(survey, stations, coord_spread) do
    CompassIO.Survey.station_atoms(survey)
    |> Enum.map(&coordinates(&1, stations, coord_spread))
  end

  def to_svg({cart_x,cart_y}, {x_max, y_max}) do
    screen_x = (x_max/2 + (cart_x)*1)
    screen_y = (y_max/2 - (cart_y)*-1)
    {screen_x,screen_y}
  end

  # get the max range of x or y coordinates
  def coord_spread(stations) do
    # getting the spread of coordinates, there must be a better elixir way!
    coords = Enum.map(stations, &(Tuple.to_list(&1.point.coordinates)))
    x_coords = Enum.map(coords, &(List.first(&1)))
    x_max = Enum.max(x_coords) - Enum.min(x_coords)

    y_coords = Enum.map(coords, &(List.last(&1)))
    y_max = Enum.max(y_coords) - Enum.min(y_coords)

    {x_max, y_max}
  end

  def station_at(station_atom, stations) do
    station_atoms = Enum.map(stations, &({String.to_atom(&1.name), &1}))
    station_atoms[station_atom]
  end
end

