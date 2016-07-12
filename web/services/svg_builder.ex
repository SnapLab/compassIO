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
    |> coordinate_transfomer(cave, stations)
    |> Tuple.to_list
    |> Enum.join(",")
  end

  defp coordinates_at(station_name, stations) do
    station_atoms = Enum.map(stations, &({ String.to_atom(&1.name), &1}))
    station_atoms[String.to_atom(station_name)].point.coordinates
  end

  defp coordinate_transfomer({cart_x, cart_y},
      %Cave{svg_canvas_x: canvas_x, svg_canvas_y: canvas_y},
      stations, target_width \\ 400) do

    scale_factor = target_width / Enum.max([canvas_x, canvas_y])

    # 0. get the min x and min y coords
    coords = Enum.map(stations, &(Tuple.to_list(&1.point.coordinates)))
    x_min = Enum.min(Enum.map(coords, &(List.first(&1))))
    y_min = Enum.min(Enum.map(coords, &(List.last(&1))))

    # 1. shift the coordinates to the new axis and scale
    shifted_x = (cart_x - x_min) * scale_factor
    shifted_y = ((cart_y - y_min) * scale_factor)

    # 2. rotate to display 'north' up
    # http://benn.org/2007/01/06/rotating-coordinates-around-a-centre/
    center = target_width/2
    angle = Maths.to_radians(-90)
    screen_x =  center +  :math.cos(angle) * (shifted_x - center) -  :math.sin(angle) * (shifted_y - center)
    screen_y = center + :math.sin(angle) * (shifted_x - center) +  :math.cos(angle) * (shifted_y - center)

    {screen_x,screen_y}
  end
end
