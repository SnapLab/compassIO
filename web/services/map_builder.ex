defmodule MapBuilder do
  alias CompassIO.Repo
  alias CompassIO
  alias CompassIO.StationBuilder
  alias CompassIO.SvgBuilder

  # takes a changeset and returns {:ok, cave}
  def create(changeset) do
    case Repo.insert(changeset) do
      {:ok, cave} ->

        cave
        |> StationBuilder.run
        |> SvgBuilder.run
        {:ok, cave}

      {:error, changeset}  ->
        {:error, changeset}
    end
  end

  # takes a changeset and returns {:ok, cave}
  def update(changeset) do
    case Repo.update(changeset) do
      {:ok, cave} ->
        cave
        |> StationBuilder.run
        |> SvgBuilder.run
        {:ok, cave}
      {:error, changeset} ->
        {:error, changeset}
    end
  end
end

