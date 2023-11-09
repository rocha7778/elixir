import Config

# REST API Configuration
config :pocket_information,
  port: 8080,
  env: Mix.env()

# REST API metrics Configuration
config :pocket_information,
  port_to_expose_metrics: 8082,
  env: Mix.env()

# profiling variables
config :pocket_information,
  micro_seconds: 1_000_000,
  limit_second_to_response: 0

# SSL Configuration
config :pocket_information,
  certfile_secret_path:
    "kv/integracion/OpenShift/deposits-services/certs/depositsservices.ambientesbc.lab.cer",
  private_key_secret_path:
    "kv/integracion/OpenShift/deposits-services/secrets/deposits-private.key",
  certfile_secret_key: "cert",
  private_key_secret_key: "key",
  private_key_passphrase_secret_key: "pass",
  certfile_target_path: File.cwd!() <> "/lib/pocket_information/priv/cert.pem",
  keyfile_target_path: File.cwd!() <> "/lib/pocket_information/priv/private-key.key",
  cacert_path: File.cwd!() <> "/lib/pocket_information/priv/cacert.pem"

# HTTP LIBRARY
#config :http_connector,
#  http_timeout: 3000,
#  cacert_path: File.cwd!() <> "/lib/priv/cacerts.pem"

# Dependency Injection
config :pocket_information,
  pocket_repository_impl: PocketInformation.Adapters.Repositories.PocketRepositoryTestImpl,
  account_conditions_impl: PocketInformation.Adapters.Http.AccountConditionsImpl,
  category_repository_impl: PocketInformation.Adapters.Repositories.CategoryRepositoryTestImpl

# API CONNECT: Retrieve Account Basic Information
config :pocket_information,
  client_id_api_account_information: "868fc151-8896-4233-a46a-5962b3447585",
  client_secret_api_account_information: "A6jC0lL8bW0yL5uI7gB0eM5dB4qM7eF2cW6jI6qS4qL1gR0oC8",
  port_api_account_information: 3000,
  http_timeout: 3000,
  host_api_account_information: "localhost",
  path_api_account_information:
    "/int/testing/v1/operations/product-specific/deposits/accounts/retrieve-basic",
  schema_api_account_information: :http

# Mongo Configuration
config :pocket_information,
  db_host: "localhost",
  db_name: "depositoa",
  db_port: 27017,
  db_pool_size: 2,
  db_pocket_collection: "bolsillos",
  db_category_collection: "bvdffblcat"

# Logging Configuration
config :logger,
       :console,
       metadata: [:request_id],
       level: :debug,
       format: "[$metadata] [$level] [$date] [$time] $message\n\n"

# Basic Authentication configuration
config :pocket_information,
  basic_auth_username: "admin",
  basic_auth_password: "admin"

# SecretManagerAcces configuration
#config :secret_manager_access,
#  client_impl: :vault,
#  host: "https://vault-integration-common.apps.ocpdes.ambientesbc.lab",
#  auth: Vault.Auth.Approle,
#  engine: Vault.Engine.KVV2,
#  json: Jason,
#  credentials: %{
#    role_id: "1ebfd60e-5305-15e7-4a0e-c8bda0dfec76",
#    secret_id: "3d34489b-b1a5-0e55-1748-0ce966747cd6"
#  }

# Kafka config
config :kafka_ex,
  consumer_group: "kafka_ex",
  client_id: "kafka_ex",
  disable_default_worker: true,
  sync_timeout: 3000,
  max_restarts: 10,
  max_seconds: 60,
  commit_interval: 5_000,
  commit_threshold: 100,
  sleep_for_reconnect: 400,
  kafka_version: "kayrock"

config :trx_logging,
  logging_enabled: false,
  brokers: "10.8.166.82:9094,10.8.166.83:9094,10.8.166.84:9094",
  use_ssl: true,
  cacert_path: File.cwd!() <> "lib/pocket_information/priv/cacert.pem",
  level: :info,
  env: Mix.env(),
  app_name: "pocket-information",
  platform: "Erlang/Elixir",
  topic: "depositos-capatrx-logs-dev",
  metadata: [:request_id]
