defmodule CompassIO.DatFile.Shot do
  defstruct from_station: "", to_station: "", length: "", bearing: "",
    inclination: "", flags: "", comment: ""

  def from_station(shot) do
    shot.from_station
  end

  def to_station(shot) do
    shot.to_station
  end

  def inclination(shot) do
    {degrees, _} = Float.parse(shot.inclination)
    degrees
  end

  def depth_change(shot) do
    (:math.sin(Maths.to_radians(inclination(shot))) * distance(shot))
    |> Float.round(0)
    |> positivity(shot)
  end

  def flags(shot) do
    shot.flags
  end

  def distance(shot) do
    {val, _} = Float.parse(shot.length)
    val
  end

  def azimuth(shot) do
    {val, _} = Float.parse(shot.bearing)
    val
  end

  defp down?(shot) do
    Float.parse(shot.inclination) < 0
  end

  defp positivity(number, shot) do
    if down?(shot), do: (0 - number), else: number
  end
end

