defmodule CompassIO.Cave do
  use CompassIO.Web, :model

  schema "caves" do
    field :name, :string
    field :station_start
    has_many :surveys, CompassIO.Survey

    timestamps
  end

  @required_fields ~w(name)
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :invalid) do
    model
    |> cast(params, @required_fields, @optional_fields)
    |> cast_assoc(:surveys)
  end
end
