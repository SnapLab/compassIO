defmodule CompassIO.Repo.Migrations.AddSvgPointToStations do
  use Ecto.Migration

  def change do
    alter table(:stations) do
      add :svg_point, :string
    end
  end
end
