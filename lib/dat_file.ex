defmodule CompassIO.DatFile do

  def reader(filename) do
    case File.read(filename) do
      {:error, :enoent} ->
        {:error, "File could not be opened"}

      {:ok, data} ->
        raw_surveys =
          String.split(data, "\f\r")
          |> List.delete_at(-1) # remove the last record, it's not a survey

        cave_name =
          String.split(data, "\n") |> List.first |> String.strip

        {:ok,
          %Cave{
            name: cave_name,
            surveys: Enum.map(raw_surveys, &read_survey(&1))
          }
        }
    end
  end

  defp read_survey(raw_survey) do
    %Survey{
      name: read_attr(raw_survey, :survey_name),
      survey_date: read_attr(raw_survey, :survey_date),
      comment: read_attr(raw_survey, :survey_comment),
      team: read_attr(raw_survey, :team),
      shots: Enum.map(read_attr(raw_survey, :shots), &read_shot(&1))
    }
  end

  defp read_shot(raw_shot) do
    shot =
      String.split(raw_shot, " ")
      |> Enum.filter(&(&1 != ""))

    %Shot{
      from_station: Enum.fetch!(shot, 0),
      to_station:  Enum.fetch!(shot, 1),
      length:  Enum.fetch!(shot, 2),
      bearing:  Enum.fetch!(shot, 3),
      inclination:  Enum.fetch!(shot, 4)
    }
  end

  defp read_attr(raw_survey, :survey_name) do
    Regex.run(~r/SURVEY NAME:(.*?)\r\n/, raw_survey)
    |> read_capture_from_list
  end

  defp read_attr(raw_survey, :survey_date) do
    Regex.run(~r/SURVEY DATE:(.*?)COMMENT/, raw_survey)
    |> read_capture_from_list
    |> cleanup_survey_date
  end

  defp read_attr(raw_survey, :survey_comment) do
    Regex.run(~r/COMMENT:(.*?)\r\n/, raw_survey)
    |> read_capture_from_list
  end

  defp read_attr(raw_survey, :team) do
    Regex.run(~r/SURVEY TEAM: \r\n(.*?)\r\n/, raw_survey)
    |> read_capture_from_list
  end

  defp read_attr(raw_survey, :shots) do
    String.split(raw_survey, ~r/FLAGS  COMMENTS\r\n\r\n(.*?)/)
    |> List.last
    |> String.split(~r/\r\n/)
    |> List.delete_at(-1) # remove the last record, it's not a shot
  end

  defp read_capture_from_list(list) do
    cond do
      is_list(list) ->
        List.last(list)
        |> String.strip
      true ->
        ""
    end
  end

  defp cleanup_survey_date(raw_date) do
    [{month, _}, {day, _}, {year, _}] =
      for x <- String.split(raw_date, " "), do: Integer.parse(x)

    Timex.date({year, month, day})  |> Timex.format!("%Y-%m-%d", :strftime)
  end
end
