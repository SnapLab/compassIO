defmodule CompassIO.Repo.Migrations.AddStationsToSurveys do
  use Ecto.Migration

  def change do
    alter table(:surveys) do
      add :stations, {:array, :map}, default: []
    end
  end
end
