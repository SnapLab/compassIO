defmodule CompassIO.Repo.Migrations.CreateStations do
  use Ecto.Migration

  def change do
    create table(:stations) do
      add :survey_id, references(:surveys, on_delete: :delete_all)
      add :cave_id, references(:caves, on_delete: :delete_all)
      add :name, :string
      add :depth, :float
      add :point, :string
      timestamps
    end
    create index(:stations, [:survey_id])
    create index(:stations, [:name, :cave_id], unique: true)
  end
end
