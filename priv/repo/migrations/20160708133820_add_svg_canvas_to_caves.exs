defmodule CompassIO.Repo.Migrations.AddSvgCanvasToCaves do
  use Ecto.Migration

  def change do
    alter table(:caves) do
      add :svg_canvas_x, :float
      add :svg_canvas_y,  :float
    end
  end
end
