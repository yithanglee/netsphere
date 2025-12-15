# In this file, we load production configuration and secrets
# from environment variables. You can also hardcode secrets,
# although such is generally not recommended and you have to
# remember to add this file to your .gitignore.
use Mix.Config

database_url =
  System.get_env("DATABASE_URL") ||
    raise """
    environment variable DATABASE_URL is missing.
    For example: ecto://USER:PASS@HOST/DATABASE
    """

config :commerce_front, CommerceFront.Repo,
  # ssl: true,
  url: database_url,
  pool_size: String.to_integer(System.get_env("POOL_SIZE") || "10")

secret_key_base =
  System.get_env("SECRET_KEY_BASE") ||
    raise """
    environment variable SECRET_KEY_BASE is missing.
    You can generate one by calling: mix phx.gen.secret
    """

config :commerce_front, CommerceFrontWeb.Endpoint,
  http: [
    port: String.to_integer(System.get_env("PORT") || "4000"),
    transport_options: [socket_opts: [:inet6]]
  ],
  secret_key_base: secret_key_base

# ## Using releases (Elixir v1.9+)
#
# If you are doing OTP releases, you need to instruct Phoenix
# to start each relevant endpoint:
#
#     config :commerce_front, CommerceFrontWeb.Endpoint, server: true
#
# Then you can assemble a release by calling `mix release`.
# See `mix help release` for more information.
config :commerce_front, CommerceFrontWeb.Endpoint, server: true

config :commerce_front, url: System.get_env("ENDPOINT_PROD")

config :commerce_front, :billplz,
  key: System.get_env("BILLPLZ_API_KEY_PROD"),
  endpoint: System.get_env("BILLPLZ_API_ENDPOINT_PROD"),
  callback: System.get_env("BILLPLZ_API_CALLBACK_URL_PROD")

config :commerce_front, :razer,
  vkey: System.get_env("RAZER_VKEY_PROD"),
  mid: System.get_env("RAZER_MID_PROD"),
  endpoint: System.get_env("RAZER_ENDPOINT_PROD")

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

config :rustler_precompiled, :force_build, ex_secp256k1: true
config :rustler_precompiled, :force_build, ex_keccak: true

config :commerce_front, :nowpayments,
  endpoint: "https://api.nowpayments.io",
  api_key: System.get_env("NOWPAYMENTS_API_KEY"),
  # how you price internally
  price_currency: "USD",
  callback: System.get_env("NOWPAYMENTS_CALLBACK_URL_PROD"),
  success_url: System.get_env("NOWPAYMENTS_SUCCESS_URL_PROD"),
  cancel_url: System.get_env("NOWPAYMENTS_CANCEL_URL_PROD")
