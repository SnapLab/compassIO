defmodule CompassIO.Repo.Migrations.AddSvgPolylinePointsToSurveys do
  use Ecto.Migration

  def change do
    alter table(:surveys) do
      add :svg_polyline_points, :text
    end
  end
end
