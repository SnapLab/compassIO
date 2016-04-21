defmodule CompassIO.Shot do
  use Ecto.Model

  embedded_schema do
    field :depth_change
    field :azimuth
    field :distance
  end
end
