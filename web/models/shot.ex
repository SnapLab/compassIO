defmodule CompassIO.Shot do
  use Ecto.Schema

  embedded_schema do
    field :depth_change
    field :azimuth
    field :distance
  end
end
