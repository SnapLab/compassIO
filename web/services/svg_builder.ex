defmodule CompassIO.SvgBuilder do
  import Ecto.Query, only: [from: 2]

  alias CompassIO.Repo
  alias CompassIO.Cave
  alias CompassIO.Survey
  alias CompassIO.Station
  alias CompassIO.Shot

  def run(cave) do
    stations =
      Repo.all(from s in Station, where: s.cave_id == ^cave.id, order_by: s.name)

    Repo.get!(Cave, cave.id)
    |> Repo.preload(:surveys)
    |> set_canvas(stations)
    |> set_svg_polylines(stations)
  end

  defp set_canvas(cave, []), do: cave
  defp set_canvas(cave, stations) do
    coords = Enum.map(stations, &(Tuple.to_list(&1.point.coordinates)))

    x_coords = Enum.map(coords, &(List.first(&1)))
    x_max = Enum.max(x_coords) - Enum.min(x_coords)

    y_coords = Enum.map(coords, &(List.last(&1)))
    y_max = Enum.max(y_coords) - Enum.min(y_coords)

    Cave.changeset(cave, %{svg_canvas_x: x_max, svg_canvas_y: y_max})
    |> Repo.update!
  end

  defp set_svg_polylines(cave, stations) do
    Enum.map(cave.surveys,
        &(&1
          |> Repo.preload(shots: from(s in Shot, order_by: s.id))
          |> Repo.preload(:cave)
          |> set_svg_polyline_points(stations)
          ))
    Repo.get!(Cave, cave.id)
  end

  defp set_svg_polyline_points(survey, stations) do
    station_names = Survey.station_names(survey)

    svg_polyline_points =
      Enum.map(station_names, &(svg_coordinates(&1, survey.cave, stations)))
      |> Enum.join(" ")

    Survey.changeset(survey, %{svg_polyline_points: svg_polyline_points})
    |> Repo.update!
  end

  # given a stations, return the svg friendly coordinates
  defp svg_coordinates(station_name, cave, stations) do
    coordinates_at(station_name, stations)
    |> coordinate_transfomer(cave.svg_canvas_x, cave.svg_canvas_y)
    |> Tuple.to_list
    |> Enum.join(",")
  end

  defp coordinates_at(station_name, stations) do
    station_atoms = Enum.map(stations, &({ String.to_atom(&1.name), &1}))
    station_atoms[String.to_atom(station_name)].point.coordinates
  end

  defp coordinate_transfomer({cart_x,cart_y}, x_max, y_max) do
    screen_x = (x_max/2 + (cart_x)*1)
    screen_y = (y_max/2 - (cart_y)*-1)
    {screen_x,screen_y}
  end
end
