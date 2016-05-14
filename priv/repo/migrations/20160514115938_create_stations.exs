defmodule CompassIO.Repo.Migrations.CreateStations do
  use Ecto.Migration

  def change do
    create table(:stations) do
      add :survey_id, references(:surveys, on_delete: :nothing)
      add :name, :string
      add :depth, :float
      add :point, :string
      timestamps
    end
    create index(:stations, [:survey_id])
  end
end
