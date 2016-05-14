defmodule CompassIO.Repo.Migrations.CreateSurvey do
  use Ecto.Migration

  def change do
    create table(:surveys) do
      add :cave_id, references(:caves, on_delete: :delete_all)
      add :name, :string
      add :survey_date, :date
      add :comment, :text
      add :team, :string
      add :tie_in, :string
      add :prefix, :string
      add :shots, {:array, :map}, default: []
      timestamps
    end
    create index(:surveys, [:cave_id])

  end
end
