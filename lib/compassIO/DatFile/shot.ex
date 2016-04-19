defmodule CompassIO.DatFile.Shot do
  defstruct from_station: "", to_station: "", length: "", bearing: "",
    inclination: "", flags: "", comment: ""

  def depth_change(shot) do
    {degrees, _} = Float.parse(shot.inclination)

    (:math.sin(to_radians(degrees)) * distance(shot))
    |> Float.round(0)
    |> positivity(shot)
  end

  def distance(shot) do
    {val, _} = Float.parse(shot.length)
    val
  end

  def azimuth(shot) do
    {val, _} = Integer.parse(shot.bearing)
    val
  end

  defp down?(shot) do
    Float.parse(shot.inclination) < 0
  end

  defp to_radians(degrees) do
    degrees * (:math.pi / 180)
  end

  defp positivity(number, shot) do
    if down?(shot), do: (0 - number), else: number
  end
end

