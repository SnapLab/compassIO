defmodule CompassIO.Shot do
  use Ecto.Schema

  embedded_schema do
    field :depth_change, :float
    field :azimuth, :float
    field :distance, :float
  end
end
