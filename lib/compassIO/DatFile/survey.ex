defmodule CompassIO.DatFile.Survey do
  defstruct name: "", survey_date: "", comment: "", team: "", shots: []

  def tie_in(survey) do
    first_station = List.first(survey.shots).from_station
    if Regex.match?(~r/#{ prefix(survey) }/, first_station) do
      ""
    else
      first_station
    end
  end

  def prefix(survey) do
    %{"prefix" => result} =
      Regex.named_captures(~r/(?<prefix>[^\d]*)/,
        List.first(survey.shots).to_station)
    result
  end
end
