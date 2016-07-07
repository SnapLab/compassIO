defmodule CompassIO.Api.SvgView do
  use CompassIO.Web, :view

  def render("show.json", %{cave: cave, surveys: surveys, stations: stations}) do
    %{
      cave:
        %{
            id: cave.id,
            name: cave.name,
            surveys: Enum.map(surveys, &render_survey(&1, stations))
        }
     }
  end

  def render_survey(survey, stations) do
    %{
      key: survey.prefix,
      points: points(survey, stations)
    }
  end

  def coordinates(station_atom, stations) do
    stations[station_atom].point.coordinates
    |> to_svg
    |> Tuple.to_list
  end

  def points(survey, stations) do
    CompassIO.Survey.station_atoms(survey)
    |> Enum.map(&coordinates(&1, stations))
  end

  def to_svg({cart_x,cart_y}, cart_w \\ 400, cart_h \\ 400) do
    screen_x = cart_x + cart_w/2
    screen_y = cart_h/2 - cart_y
    {screen_x,screen_y}
  end
end
