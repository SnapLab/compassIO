defmodule CompassIO.DatFile do
  def reader(filename) do
    data = File.read!(filename)
    raw_surveys = String.split(data, "\f\r")

    cave_name =
      String.split(data, "\n") |> List.first |> String.strip

    %Cave{
      name: cave_name,
      surveys: Enum.map(raw_surveys, &read_survey(&1))
    }
  end

  defp read_survey(raw_survey) do
    %Survey{
      name: read_attr(raw_survey, :survey_name),
      survey_date: "2016-03-05",
      comment: "Taking a shot from"
    }
  end

  defp read_attr(raw_survey, :survey_name) do
    list = Regex.run(~r/SURVEY NAME: (.*?)\r\n/, raw_survey)
    cond do
      is_list(list) ->
        List.last list
      true ->
        ""
     end
  end
end
