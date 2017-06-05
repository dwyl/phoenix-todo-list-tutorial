# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :api,
  ecto_repos: [Api.Repo]

# Configures the endpoint
config :api, Api.Web.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "HMedmYI8VagU/HY44MVjmFJcUcr0eTmGgTeI4tG4se9ZQcwjc95Dh0fb1oSZgTSy",
  render_errors: [view: Api.Web.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Api.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
