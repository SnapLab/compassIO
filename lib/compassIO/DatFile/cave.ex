defmodule CompassIO.DatFile.Cave do
  defstruct name: "", surveys: []

  def station_start(cave) do
    survey = List.first(cave.surveys)
    List.first(survey.shots).from_station
  end
end
