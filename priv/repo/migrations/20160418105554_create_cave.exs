defmodule CompassIO.Repo.Migrations.CreateCave do
  use Ecto.Migration

  def change do
    create table(:caves) do
      add :name, :string

      timestamps
    end

  end
end
