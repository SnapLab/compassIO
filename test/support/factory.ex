defmodule CompassIO.Factory do
  # with Ecto
  use ExMachina.Ecto, repo: CompassIO.Repo

  def factory(:cave) do
    %CompassIO.Cave{
      name: "Kan Ha",
      id: 1
    }
  end
end
