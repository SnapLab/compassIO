defmodule CompassIO.Repo.Migrations.AddStationStartToCave do
  use Ecto.Migration

  def change do
    alter table(:caves) do
      add :station_start, :string
    end
  end
end
