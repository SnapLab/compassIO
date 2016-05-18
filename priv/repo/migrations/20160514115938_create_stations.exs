defmodule CompassIO.Repo.Migrations.CreateStations do
  use Ecto.Migration

  def change do
    create table(:stations) do
      add :survey_id, references(:surveys, on_delete: :delete_all)
      add :cave_id, references(:caves, on_delete: :delete_all)
      add :name, :string
      add :depth, :float
      add :entrance_distance, :float
      add :point, :geometry
      timestamps
    end
    create index(:stations, [:survey_id])
    create unique_index(:stations, [:cave_id, :survey_id, :name], unique: true)
  end
end
