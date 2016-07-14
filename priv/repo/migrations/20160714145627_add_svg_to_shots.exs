defmodule CompassIO.Repo.Migrations.AddSvgToShots do
  use Ecto.Migration

  def change do
    alter table(:shots) do
      add :svg_station_from, :string
      add :svg_station_to, :string
    end
  end
end
