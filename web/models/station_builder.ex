defmodule CompassIO.StationBuilder do
  alias CompassIO.Repo
  alias CompassIO.Cave
  alias CompassIO.Survey
  alias CompassIO.Station


  def build(cave) do
    # cave = Repo.preload(cave, :surveys)
    # Enum.map(cave.surveys, &build_stations())
    # cave
  end

  def build(%Survey{shots: shots}, tie_in_depth) do
    build_stations(shots, %Station{depth: tie_in_depth})
  end

  defp build_stations([], _last_station) do
    []
  end

  defp build_stations([head|tail], last_station) do
    station = %{name: head.station_to, depth: head.depth_change + last_station.depth, location: '1'}
    [station | build_stations(tail, station)]
  end
end
