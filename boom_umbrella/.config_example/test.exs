import Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.


config :auth, Auth.Repo,
  database: "boom_test#{System.get_env("MIX_TEST_PARTITION")}",
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: 10

config :boom, Boom.Repo,
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  database: "boom_test#{System.get_env("MIX_TEST_PARTITION")}",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: 10

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :boom_web, BoomWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "qn5DIPUB6mwT2Uvf4v03ROawgv+darJq9IsFIxc/vEzzArFQlBoGQ5UqBwxglse0",
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# In test we don't send emails.
config :boom, Boom.Mailer, adapter: Swoosh.Adapters.Test

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
