# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :smart_ac,
  ecto_repos: [SmartAc.Repo]

# Configures the endpoint
config :smart_ac, SmartAcWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "g8Ws6K7fIxRDNeQkrYGN3aSnB0BEr7ZK5UnaX13ahevlR/v3+pnY2BGXlkloxI3c",
  render_errors: [view: SmartAcWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: SmartAc.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :smart_ac, SmartAcWeb.Guardian,
  issuer: "smart_ac",
  secret_key: "CRq103fsJnmWqzqcw+ja90qKHWABgoH/UfByvKiUC4rlPkZe3OVNZ6z2zCSK+6YK"

config :smart_ac, SmartAcWeb.AirConditionerAuthPipeline,
  module: SmartAcWeb.Guardian,
  error_handler: SmartAcWeb.AuthErrorHandler

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
