defmodule CompassIO.Shot do
  use CompassIO.Web, :model

  schema "shots" do
    field :station_from, :string
    field :depth_change, :float
    field :inclination, :float
    field :azimuth, :float
    field :distance, :float
    field :flags, :string
    field :station_to, :string
    belongs_to :survey, CompassIO.Survey

    timestamps
  end

  @required_fields ~w()
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :invalid) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end
end
