defmodule CompassIO.Repo.Migrations.AddShotsSurveys do
  use Ecto.Migration

  def change do
    alter table(:surveys) do
      add :shots, {:array, :map}, default: []
    end
  end
end
