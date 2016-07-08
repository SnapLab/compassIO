defmodule CompassIO.SvgBuilder do
  import Ecto.Query, only: [from: 2]

  alias CompassIO.Repo
  alias CompassIO.Cave
  alias CompassIO.Survey
  alias CompassIO.Station

  def build(cave) do
    stations =
      Repo.all(from s in Station, where: s.cave_id == ^cave.id, order_by: s.name)

    Repo.get!(Cave, cave.id)
    |> Repo.preload(:surveys)
    |> set_canvas(stations)
    |> set_svg_polylines(stations)
  end

  def set_canvas(cave, []), do: cave
  def set_canvas(cave, stations) do
    coords = Enum.map(stations, &(Tuple.to_list(&1.point.coordinates)))

    x_coords = Enum.map(coords, &(List.first(&1)))
    x_max = Enum.max(x_coords) - Enum.min(x_coords)

    y_coords = Enum.map(coords, &(List.last(&1)))
    y_max = Enum.max(y_coords) - Enum.min(y_coords)

    Cave.changeset(cave, %{svg_canvas_x: x_max, svg_canvas_y: y_max})
    |> Repo.update!
  end

  def set_svg_polylines(cave, stations) do
    Enum.map(cave.surveys, &set_svg_polyline_points(&1, stations))
  end

  def set_svg_polyline_points(survey, _stations) do
    # THIS IS A MESS - why can't I update this fucking attribute without preloading assocations???
    survey
    |> Repo.preload(:shots)
    |> Survey.changeset(%{svg_polyline_points: "123"})
    |> Repo.update!
  end

#  BELOW IS FOR REFERNCE - this is what I need to do
  # def coordinates(station_atom, stations, coord_spread) do
  #   station_at(station_atom, stations).point.coordinates
  #   |> to_svg(coord_spread)
  #   |> Tuple.to_list
  # end

  # def points(survey, stations, coord_spread) do
  #   CompassIO.Survey.station_atoms(survey)
  #   |> Enum.map(&coordinates(&1, stations, coord_spread))
  # end

  # def to_svg({cart_x,cart_y}, {x_max, y_max}) do
  #   screen_x = (x_max/2 + (cart_x)*1)
  #   screen_y = (y_max/2 - (cart_y)*-1)
  #   {screen_x,screen_y}
  # end

  # # get the max range of x or y coordinates
  # def coord_spread(stations) do
  #   # getting the spread of coordinates, there must be a better elixir way!
  #   coords = Enum.map(stations, &(Tuple.to_list(&1.point.coordinates)))
  #   x_coords = Enum.map(coords, &(List.first(&1)))
  #   x_max = Enum.max(x_coords) - Enum.min(x_coords)

  #   y_coords = Enum.map(coords, &(List.last(&1)))
  #   y_max = Enum.max(y_coords) - Enum.min(y_coords)

  #   {x_max, y_max}
  # end

  # def station_at(station_atom, stations) do
  #   station_atoms = Enum.map(stations, &({String.to_atom(&1.name), &1}))
  #   station_atoms[station_atom]
  # end
end
