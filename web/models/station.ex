defmodule CompassIO.Station do
  use CompassIO.Web, :model

  schema "stations" do
    field :name, :string
    field :depth, :float, default: 0.0
    field :point, Geo.Point
    field :entrance_distance, :float, default: 0.0
    belongs_to :survey, CompassIO.Survey
    belongs_to :cave, CompassIO.Cave

    timestamps
  end

  @required_fields ~w(name survey_id cave_id depth)
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :invalid) do
    model
    |> cast(params, @required_fields, @optional_fields)
    |> unique_constraint(:name)
    |> foreign_key_constraint(:survey_id)
    |> unique_constraint(:name_survey_id)
  end
end
