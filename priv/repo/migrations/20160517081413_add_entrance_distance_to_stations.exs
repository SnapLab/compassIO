defmodule CompassIO.Repo.Migrations.AddEntranceDistanceToStations do
  use Ecto.Migration

  def change do
    alter table(:stations) do
      add :entrance_distance, :float
    end
  end
end
