defmodule CompassIO.Station do
  use Ecto.Schema

  embedded_schema do
    field :name
    field :depth
  end
end
