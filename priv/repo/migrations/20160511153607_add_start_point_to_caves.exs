defmodule CompassIO.Repo.Migrations.AddStartPointToCaves do
  use Ecto.Migration

  def change do
    alter table(:caves) do
      add :start_point, :geometry
    end
  end
end
