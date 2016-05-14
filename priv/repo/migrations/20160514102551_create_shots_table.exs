defmodule CompassIO.Repo.Migrations.CreateShotsTable do
  use Ecto.Migration

  def change do
    create table(:shots) do
      add :survey_id, references(:surveys, on_delete: :nothing)
      add :station_from, :string
      add :depth_change, :float
      add :inclination, :float
      add :azimuth, :float
      add :distance, :float
      add :flags, :string
      add :station_to, :string
      timestamps
    end
    create index(:shots, [:survey_id])
  end
end
