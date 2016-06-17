use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :compassIO, CompassIO.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :compassIO, CompassIO.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "toby",
  password: "",
  database: "compassio_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox,
  extensions: [{Geo.PostGIS.Extension, library: Geo}]


config :compassIO, :basic_auth, [
  realm: "Under Construction!",
  username: "admin",
  password: "admin"
]
