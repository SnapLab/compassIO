defmodule CompassIO.Repo.Migrations.CreateSurvey do
  use Ecto.Migration

  def change do
    create table(:surveys) do
      add :name, :string
      add :survey_date, :date
      add :comment, :text
      add :team, :string
      add :tie_in, :string
      add :prefix, :string
      add :cave_id, references(:caves, on_delete: :nothing)

      timestamps
    end
    create index(:surveys, [:cave_id])

  end
end
