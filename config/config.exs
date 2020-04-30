# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

# Configures the endpoint
config :pastie, PastieWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "4eOfU7e4ryTjbenygjvnQdxy14yOFHlhgr5JOfMkYWyUSPXD+W3rp45dmRn9zeZ9",
  render_errors: [view: PastieWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Pastie.PubSub,
  live_view: [signing_salt: "qU0bFX4b"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
