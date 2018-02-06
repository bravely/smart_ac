use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :smart_ac, SmartAcWeb.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :smart_ac, SmartAc.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "smart_ac_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

config :argon2_elixir,
  t_cost: 2,
  m_cost: 12
