# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :pho_upload,
  ecto_repos: [PhoUpload.Repo]

# Configures the endpoint
config :pho_upload, PhoUpload.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "aRA2+D53Yem6mt7CrFU/NVXTfHsiNS/jVFAT4WHkJ/BkknXfRQdJYVQBl3pIVDek",
  render_errors: [view: PhoUpload.ErrorView, accepts: ~w(json)],
  pubsub: [name: PhoUpload.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
