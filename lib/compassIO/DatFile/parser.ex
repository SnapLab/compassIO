defmodule CompassIO.DatFile.Parser do

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

    %{
      name: cave_struct.name,
      surveys: Enum.map(cave_struct.surveys, &parse_survey(&1))
     }
  end

  defp parse_survey(survey_struct) do
    %{
      name: survey_struct.name,
      survey_date: survey_struct.survey_date,
      team: survey_struct.team,
      comment: survey_struct.comment
    }
  end
end
