use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :spacex_mission_api, SpacexMissionApi.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :spacex_mission_api, SpacexMissionApi.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "teladoc",
  password: "teladoc",
  database: "spacex_mission_api_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
