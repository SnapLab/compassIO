defmodule CompassIO.DatFile do
  def reader(filename) do
    data = File.read!(filename)

    raw_surveys =
      String.split(data, "\f\r")
      |> List.delete_at(-1) # remove the last record, it's not a survey

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
      survey_date: read_attr(raw_survey, :survey_date),
      comment: "Taking a shot from"
    }
  end

  defp read_attr(raw_survey, :survey_name) do
    Regex.run(~r/SURVEY NAME: (.*?)\r\n/, raw_survey)
    |> read_capture_from_list
  end

  defp read_attr(raw_survey, :survey_date) do
    Regex.run(~r/SURVEY DATE: (.*?)COMMENT/, raw_survey)
    |> read_capture_from_list
    |> cleanup_survey_date
  end

  defp read_capture_from_list(list) do
    List.last(list) |> String.strip
  end

  defp cleanup_survey_date(raw_date) do
    [{month, _}, {day, _}, {year, _}] =
      for x <- String.split(raw_date, " "), do: Integer.parse(x)

    Timex.date({year, month, day})  |> Timex.format!("%Y-%m-%d", :strftime)
  end
end
