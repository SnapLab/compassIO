defmodule CompassIO.Survey do
  use CompassIO.Web, :model
  alias CompassIO.Station

  schema "surveys" do
    field :name, :string
    field :survey_date, Ecto.Date
    field :comment, :string
    field :team, :string
    field :tie_in, :string
    field :prefix, :string
    belongs_to :cave, CompassIO.Cave
    embeds_many :shots, CompassIO.Shot
    embeds_many :stations, CompassIO.Station

    timestamps
  end

  @required_fields ~w(name cave_id)
  @optional_fields ~w(survey_date comment team tie_in prefix)

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :invalid) do
    model
    |> cast(params, @required_fields, @optional_fields)
    |> cast_embed(:shots)
    |> cast_embed(:stations)
  end

  def tie_in_station(model) do
    %Station{name: List.first(model.shots).station_from, depth: 0.0}
  end

  def build_stations(model) do
    stations = Enum.map(model.shots, &build_station(&1))
    |> List.insert_at(0, tie_in_station(model))

    insert_depth(stations, List.first(stations))
  end

  defp build_station(shot) do
    %Station{
      name: shot.station_to,
      depth_change: shot.depth_change
    }
  end

  defp insert_depth([], _) do
    []
  end
  defp insert_depth([head|tail], station_from) do
    station = Map.merge(head, %{depth: station_from.depth + head.depth_change})
    [station | insert_depth(tail, station)]
  end
end
