defmodule CompassIO.TestHelpers do
  alias CompassIO.Repo

  def insert_cave(attrs) do
    Repo.insert!(attrs)
  end
end
