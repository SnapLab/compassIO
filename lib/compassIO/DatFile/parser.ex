defmodule CompassIO.DatFile.Parser do
  alias CompassIO.DatFile.Cave
  alias CompassIO.DatFile.Survey
  alias CompassIO.DatFile.Shot

  @doc """
  Takes a filename and returns a CompassIO.Cave, by calling
  CompassIO.DatFile.Reader.read(filename) and converts that
  output to a CompassIO.Cave

  ## Example:
      iex> filename = "test/support/Linea\ Dorada.dat"
      iex> CompassIO.DatFile.Parser.read(filename)
      "{name: "Linea Dorada", surveys: []}..."
  """

  def parse(filename) do
    {:ok, cave_struct} = CompassIO.DatFile.Reader.read(filename)

    %CompassIO.Cave{
      name: cave_struct.name,
      station_start: Cave.station_start(cave_struct),
      surveys: Enum.map(cave_struct.surveys, &parse_survey(&1))
     }
  end

  defp parse_survey(survey_struct) do
    survey = %CompassIO.Survey{
      name: survey_struct.name,
      survey_date: Ecto.Date.cast!(survey_struct.survey_date),
      team: survey_struct.team,
      comment: survey_struct.comment,
      tie_in: Survey.tie_in(survey_struct),
      prefix: Survey.prefix(survey_struct),
      shots: Enum.map(survey_struct.shots, &parse_shot(&1))
    }
  end

  defp parse_shot(shot_struct) do
    %CompassIO.Shot{
      station_from: Shot.from_station(shot_struct),
      inclination: Shot.inclination(shot_struct),
      depth_change: Shot.depth_change(shot_struct),
      distance: Shot.distance(shot_struct),
      azimuth: Shot.azimuth(shot_struct),
      flags: Shot.flags(shot_struct),
      station_to: Shot.to_station(shot_struct)
    }
  end
end
