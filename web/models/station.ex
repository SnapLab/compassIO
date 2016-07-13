defmodule CompassIO.Station do
  use CompassIO.Web, :model

  schema "stations" do
    field :name, :string
    field :depth, :float, default: 0.0
    field :point, Geo.Point
    field :entrance_distance, :float, default: 0.0
    field :svg_point, :string
    belongs_to :survey, CompassIO.Survey
    belongs_to :cave, CompassIO.Cave

    timestamps
  end

  @required_fields ~w(name survey_id cave_id depth point)
  @optional_fields ~w(svg_point)

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

  def point_json(model) do
    unless is_nil(model.point) do
      Geo.JSON.encode(model.point)
    end
  end
end
