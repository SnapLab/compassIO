ExUnit.start

Mix.Task.run "ecto.create", ~w(-r CompassIO.Repo --quiet)
Mix.Task.run "ecto.migrate", ~w(-r CompassIO.Repo --quiet)
Ecto.Adapters.SQL.Sandbox.mode(CompassIO.Repo, :manual)

