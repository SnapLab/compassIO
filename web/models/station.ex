defmodule CompassIO.Station do
  use Ecto.Schema

  embedded_schema do
    field :name
    field :depth, :float, default: 0.0
    field :depth_change, :float, default: 0.0
  end
end
