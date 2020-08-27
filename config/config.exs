# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :light,
  ecto_repos: [Light.Repo]

# Configures the endpoint
config :light, LightWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "FEz90TPFkC7sapVxFX+S8FpVF+bKnf3rAPumyjHl9TimeFM0vLZh50DBHSK/HCAL",
  render_errors: [view: LightWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Light.PubSub,
  live_view: [signing_salt: "1n+95t0K"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
