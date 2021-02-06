# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :syncing_server,
  ecto_repos: [SyncingServer.Repo],
  default_cost: 11

config :syncing_server, SyncingServer.Accounts.Guardian,
  issuer: "syncing_server",
  secret_key: "5WqRR18qLqHqWQeFvdTi7hqTrjWXzZVarYhWBCgMIe+35/QlVM+MgXdS46QPPYGc"

# Configures the endpoint
config :syncing_server, SyncingServerWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "Y08n27C1FhF129ZGXWjgMi/wwwwFfDz8ZDSvfs0lBa6cIYFAz4dl5/x+vh/Mb3O6",
  render_errors: [view: SyncingServerWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: SyncingServer.PubSub,
  live_view: [signing_salt: "tMOUDC2T"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
