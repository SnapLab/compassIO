defmodule CompassIO.Shot do
  use Ecto.Schema

  embedded_schema do
    field :station_from
    field :depth_change, :float
    field :inclination, :float
    field :azimuth, :float
    field :distance, :float
    field :flags
    field :station_to
  end
end
