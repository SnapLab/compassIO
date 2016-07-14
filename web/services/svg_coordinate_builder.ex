defmodule CompassIO.SvgCoordinateBuilder do
  alias CompassIO.Cave

  # given a stations, return the svg friendly coordinates
  def build(station_name, cave, stations) do
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
      stations) do

    target_width = Enum.max([canvas_x, canvas_y])

    # 0. get the min x and min y coords
    coords = Enum.map(stations, &(Tuple.to_list(&1.point.coordinates)))
    x_min = Enum.min(Enum.map(coords, &(List.first(&1))))
    y_min = Enum.min(Enum.map(coords, &(List.last(&1))))

    # 1. shift the coordinates to the new axis
    shifted_x = (cart_x - x_min)
    shifted_y = ((cart_y - y_min))

    # 2. rotate to display 'north' up
    # http://benn.org/2007/01/06/rotating-coordinates-around-a-centre/
    center = target_width/2
    angle = Maths.to_radians(-90)
    screen_x =  center +  :math.cos(angle) * (shifted_x - center) -  :math.sin(angle) * (shifted_y - center)
    screen_y = center + :math.sin(angle) * (shifted_x - center) +  :math.cos(angle) * (shifted_y - center)

    {screen_x,screen_y}
  end
end
