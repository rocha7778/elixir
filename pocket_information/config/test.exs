import Config

# REST API Configuration
config :pocket_information,
  port: 8080,
  env: Mix.env()

# REST API metrics Configuration
config :pocket_information,
port_to_expose_metrics: 8082,
env: Mix.env()

# SSL Configuration
config :pocket_information,
  server_public_certificate_path: "./priv/ssl/depositosservices.pem",
  server_private_key_path: "./priv/ssl/depositos.key",
  server_private_passphrase: "123456789",
  castore_path: "./priv/ssl/ca.depositosservices.pem"

# Dependency Injection
config :pocket_information,
  pocket_repository_impl: PocketInformation.Test.Adapters.Repositories.PocketRepositoryTestImpl,
  category_repository_impl:
    PocketInformation.Test.Adapters.Repositories.CategoryRepositoryTestImpl

# Mongo Configuration
config :pocket_information,
       db_host: "",
       db_port: 27018,
       db_username: "",
       db_password: "",
       db_name: "",
       db_pool_size: 10,
       db_pocket_collection: "",
       db_category_collection: "",
       db_use_ssl: false

# Logging Configuration
config :logger,
       :console,
       metadata: [:request_id],
       level: :debug,
       format: "[$level] [$date] [$time] $message\n\n"

# Basic Authentication configuration
config :pocket_information,
  basic_auth_username: "admin",
  basic_auth_password: "123"

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
  brokers: "localhost:9092",
  use_ssl: true,
  cacert_path: File.cwd!() <> "lib/pocket_information/priv/cacert.pem",
  level: :info,
  env: Mix.env(),
  app_name: "pocket-information",
  platform: "Erlang/Elixir",
  topic: "depositos-capatrx-logs-dev",
  metadata: [:request_id]
