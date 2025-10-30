# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :commerce_front,
  ecto_repos: [CommerceFront.Repo]

# Configures the endpoint
config :commerce_front, CommerceFrontWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "4vvlxoQtn0Dd2irSRa4d8QUAmkBWr+SaF8x3MbsR6CXEcQga/Vy5uvh01T9YlL89",
  render_errors: [view: CommerceFrontWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: CommerceFront.PubSub,
  live_view: [signing_salt: "eHS1OdsC"]

config :commerce_front, CommerceFront.Repo,
  username: "postgres",
  password: "postgres",
  database: "commerce_front_dev",
  hostname: "localhost",
  show_sensitive_data_on_connection_error: true,
  pool_size: 10,
  timeout: 165_000

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :blue_potion,
  otp_app: "CommerceFront",
  repo: CommerceFront.Repo,
  contexts: ["Settings"],
  project: %{
    name: "CommerceFront",
    alias_name: "commerce_front",
    sname: "#{System.get_env("SNAME")}",
    vsn: "0.1.0"
  },
  server: %{
    url: "139.162.60.209",
    db_url: "127.0.0.1",
    username: "ubuntu",
    key: System.get_env("SERVER_KEY"),
    domain_name: "localhost"
  },
  stag_server: %{
    url: "192.53.172.101",
    db_url: "127.0.0.1",
    username: "ubuntu",
    key: System.get_env("STAG_SERVER_KEY"),
    domain_name: "localhost"
  }

config :commerce_front, CommerceFront.Scheduler,
  jobs: [
    {"05 0 * * 1", {CommerceFront, :daily_task, [Date.utc_today() |> Date.add(-1)]}},
    {"05 0 * * 2", {CommerceFront, :daily_task, [Date.utc_today() |> Date.add(-1)]}},
    {"05 0 * * 3", {CommerceFront, :daily_task, [Date.utc_today() |> Date.add(-1)]}},
    {"05 0 * * 4", {CommerceFront, :daily_task, [Date.utc_today() |> Date.add(-1)]}},
    {"05 0 * * 5", {CommerceFront, :daily_task, [Date.utc_today() |> Date.add(-1)]}},
    {"05 0 * * 6", {CommerceFront, :daily_task, [Date.utc_today() |> Date.add(-1)]}},
    {"05 0 * * 0", {CommerceFront, :daily_task, [Date.utc_today() |> Date.add(-1)]}},
    {"15 0 * * *", {CommerceFront.Settings, :run_daily_staking_release, []}}
  ]

config :commerce_front,
chain_id: System.get_env("CHAIN_ID"),
etherscan_api_key: System.get_env("ETHERSCAN_API_KEY"),
token_contract_address: System.get_env("TOKEN_CONTRACT_ADDRESS")

config :commerce_front, CommerceFront.Mailer,
  adapter: Bamboo.SMTPAdapter,
  server: "localhost",
  hostname: "mail.damienslab.com",
  port: 25,
  username: "ubuntu",
  password: "unwanted2",
  tls: :always,
  allowed_tls_versions: [:"tlsv1.2"],
  tls_log_level: :error,
  tls_verify: :verify_none,
  ssl: false,
  retries: 1,
  no_mx_lookups: false,
  auth: :if_available

config :commerce_front, :encryption,
  key: System.get_env("ENCRYPTION_KEY")

config :ethereumex,
  url:  System.get_env("RPC")

config :rustler_precompiled, :force_build, ex_secp256k1: true
config :rustler_precompiled, :force_build, ex_keccak: true
# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
