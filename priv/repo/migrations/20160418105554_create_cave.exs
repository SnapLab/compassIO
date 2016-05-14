defmodule CompassIO.Repo.Migrations.CreateCave do
  use Ecto.Migration

  def change do
    create table(:caves) do
      add :name, :string
      add :station_start, :string

      timestamps
    end

    create index(:caves, [:name], unique: true)
  end
end
