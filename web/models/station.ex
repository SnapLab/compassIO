defmodule CompassIO.Station do
  use CompassIO.Web, :model

  schema "stations" do
    field :name, :string
    field :depth, :float
    field :point, :string
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
    |> unique_constraint(:name)
  end
end
