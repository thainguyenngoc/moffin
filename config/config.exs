# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :mofiin,
  ecto_repos: [Mofiin.Repo]

config :mofiin, Mofiin.Auth.Guardian,
  issuer: "mofiin",
  secret_key: "bU3Rk4X+gXwOtoRQ+/ldh4U80n4T+MsyXV2ilXsx9kNO3hCgnj/ExrWA7/5WT8V1"

# Configures the endpoint
config :mofiin, Mofiin.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "zk5IlPLiii9HpSzpMbytwlpyZx4wlGcDO9MkFxDT8z1LMMz4YpepGJW/ZOPOcNml",
  render_errors: [view: Mofiin.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Mofiin.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :arc, storage: Arc.Storage.Local

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
