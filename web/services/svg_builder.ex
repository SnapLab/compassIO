defmodule CompassIO.SvgBuilder do
  import Ecto.Query, only: [from: 2]

  alias CompassIO.Repo
  alias CompassIO.Cave
  alias CompassIO.Survey
  alias CompassIO.Station
  alias CompassIO.Shot
  alias CompassIO.SvgCoordinateBuilder

  def run(cave) do
    stations = stations_for(cave)
    Repo.get!(Cave, cave.id)
    |> Repo.preload(:surveys)
    |> set_canvas(stations)
    |> set_svg_points
    |> set_svg_polylines
    |> set_svg_shots
  end

  defp set_canvas(cave, []), do: cave # handles no stations
  defp set_canvas(cave, stations) do
    coords = Enum.map(stations, &(Tuple.to_list(&1.point.coordinates)))

    x_coords = Enum.map(coords, &(List.first(&1)))
    x_max = Enum.max(x_coords) - Enum.min(x_coords)

    y_coords = Enum.map(coords, &(List.last(&1)))
    y_max = Enum.max(y_coords) - Enum.min(y_coords)

    Cave.changeset(cave, %{svg_canvas_x: x_max, svg_canvas_y: y_max})
    |> Repo.update!
  end

  defp set_svg_points(cave) do
    stations = stations_for(cave)
    Enum.map(stations, &(set_svg_point(cave, &1, stations)))
    cave
  end

  def set_svg_point(cave, station, stations) do
    Station.changeset(station, %{
      svg_point: SvgCoordinateBuilder.build(station.name, cave, stations)
      })
    |> Repo.update!
  end

  defp set_svg_polylines(cave) do
    Enum.map(cave.surveys,
        &(&1
          |> Repo.preload(shots: from(s in Shot, order_by: s.id))
          |> Repo.preload(:cave)
          |> set_svg_polyline_points(stations_for(cave))
          ))
    Repo.get!(Cave, cave.id)
  end

  defp set_svg_polyline_points(survey, stations) do
    station_names = Survey.station_names(survey)

    svg_polyline_points =
      Enum.map(station_names, &(SvgCoordinateBuilder.build(&1, survey.cave, stations)))
      |> Enum.join(" ")

    Survey.changeset(survey, %{svg_polyline_points: svg_polyline_points})
    |> Repo.update!
  end

  def set_svg_shots(cave) do
    # get all the shots in this cave
    # update station_from and station_to
    # with svg_coords from stations
    cave = cave |> Repo.preload(:surveys)
    Enum.map(cave.surveys, &(
      set_svg_shots(&1 |> Repo.preload(:shots), stations_for(cave))))

    Repo.get!(Cave, cave.id)
  end

  def set_svg_shots(survey, stations) do
    survey = survey |> Repo.preload(:cave)
    # here we call the coordinate builder, but the stations already
    # have the svg coordinate defined. It's repetitive and clumsy
    # but I guess we are avoiding a dependency
    Enum.map(survey.shots, &(
      Shot.changeset(&1,
        %{
          svg_station_from: SvgCoordinateBuilder.build(&1.station_from, survey.cave, stations),
          svg_station_to: SvgCoordinateBuilder.build(&1.station_to, survey.cave, stations)
          })
        |> Repo.update!
      ))
  end

  defp stations_for(%Cave{id: cave_id}) do
    Repo.all(from s in Station, where: s.cave_id == ^cave_id)
  end
end
