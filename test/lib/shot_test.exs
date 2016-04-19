defmodule CompassIO.DatFile.ShotTest do
  use ExUnit.Case

  alias CompassIO.DatFile.Shot

  def shot_16ft do
    %Shot{
      length: "-16.00",
      inclination: "18.21",
      bearing: "215.00"
    }
  end

  def shot_13ft do
    %Shot{
      length: "13.00",
      inclination: "4.41",
      bearing: "272.00"
    }
  end

  test "depth change" do
    assert Shot.depth_change(shot_16ft) == -5.0
    assert Shot.depth_change(shot_13ft) == 1.0
  end

  test "distance" do
    assert Shot.distance(shot_16ft) == -16.0
    assert Shot.distance(shot_13ft) == 13.0
  end

  test "azimuth" do
    assert Shot.azimuth(shot_16ft) == 215
    assert Shot.azimuth(shot_13ft) == 272
  end
end
