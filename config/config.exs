# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :banking,
  ecto_repos: [Banking.Repo]

# Configures the endpoint
config :banking, BankingWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "Prw5StSHgwS0kjo30oVmgU8sXY4HNEuUQn3o3srNk53/zsI0o+UJonBZ/48+o6Q5",
  render_errors: [view: BankingWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: Banking.PubSub,
  live_view: [signing_salt: "tYxc36H+"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :banking, BankingWeb.Guardian,
  issuer: "banking_web",
  secret_key: "Q6Q+II7ODx9bsExFnP5imdwh0qQYdEVel7stXZL+WoNADCXsgiyQ4SaMH0CtSQ+E"

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
