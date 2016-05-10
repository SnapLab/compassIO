defmodule CompassIO.Survey do
  use CompassIO.Web, :model

  schema "surveys" do
    field :name, :string
    field :survey_date, Ecto.Date
    field :comment, :string
    field :team, :string
    field :tie_in, :string
    field :prefix, :string
    belongs_to :cave, CompassIO.Cave
    embeds_many :shots, CompassIO.Shot

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
  end

  def tie_in_depth(survey) do
    tie_in = survey.tie_in
    # Begin with cave.from_station
    #  and build the depths until we find the station we want (tie_in)
    1.0
  end
end
