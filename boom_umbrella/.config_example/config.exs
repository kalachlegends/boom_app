# This file is responsible for configuring your umbrella
# and **all applications** and their dependencies with the
# help of the Config module.
#
# Note that all applications in your umbrella share the
# same configuration and dependencies, which is why they
# all use the same configuration file. If you want different
# configurations or dependencies per app, it is best to
# move said applications out of the umbrella.
import Config

config :auth, Auth.Repo,
  database: "boom_dev",
  username: "postgres",
  password: "postgres",
  hostname: "localhost"

config :boom, Boom.Repo,
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  database: "boom_dev",
  stacktrace: true,
  show_sensitive_data_on_connection_error: true,
  pool_size: 10

config :auth,
  ecto_repos: [Auth.Repo]

# joken
config :joken, default_signer: "hu#!@$DAGpCVByASDs$#@osHGJi!gGHuboyT01d234ljkoO2"

# MANUSCRIPT
config Manuscript,
  app: :boom_web,
  routes: BoomWeb.Router,
  mode: :only_routes,
  port: 10010,
  server: false,
  app_key: "1234",
  file_path_collection: "/home/artem/postman.json",
  default_variable: [
    %{
      key: "host",
      value: "http://localhost:10614/",
      type: "string"
    }
  ]

# Configure Mix tasks and generators
config :boom,
  ecto_repos: [Boom.Repo]

# Configures the mailer
#
# By default it uses the "Local" adapter which stores the emails
# locally. You can see the emails in your browser, at "/dev/mailbox".
#
# For production it's recommended to configure a different adapter
# at the `config/runtime.exs`.
config :boom, Boom.Mailer, adapter: Swoosh.Adapters.Local

# Swoosh API client is needed for adapters other than SMTP.
config :swoosh, :api_client, false

config :boom_web,
  ecto_repos: [Boom.Repo],
  generators: [context_app: :boom]

# Configures the endpoint
config :boom_web, BoomWeb.Endpoint,
  url: [host: "localhost"],
  render_errors: [view: BoomWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Boom.PubSub,
  live_view: [signing_salt: "W5DYZZ1S"]

# Configure esbuild (the version is required)
config :esbuild,
  version: "0.14.29",
  default: [
    args:
      ~w(js/app.js --bundle --target=es2017 --outdir=../priv/static/assets --external:/fonts/* --external:/images/*),
    cd: Path.expand("../apps/boom_web/assets", __DIR__),
    env: %{"NODE_PATH" => Path.expand("../deps", __DIR__)}
  ]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
