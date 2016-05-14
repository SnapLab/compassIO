defmodule CompassIO.DatFile.Cave do
  defstruct name: "", surveys: []

  def station_start(cave) do
    survey = List.first(cave.surveys)
    List.first(survey.shots).from_station
  end

  def name(cave_struct) do
    # check if the name exists
    existing_cave = CompassIO.Repo.get_by(CompassIO.Cave, name: cave_struct.name)

    name =
    if existing_cave do
      "#{ existing_cave.name }-#{ Chronos.today |> Tuple.to_list |> Enum.join("-") }-#{ :os.system_time(:seconds) }"
    else
      cave_struct.name
    end
    name
  end
end
