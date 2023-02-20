import Config

config :logger, :console, level: :debug, format: "[$level] [$date] [$time] $message\n\n"

# In your config/config.exs file
config :ecto_mongo_test, Repo,
  adapter: Mongo.Ecto,
  database: "depositoa",
  hostname: "localhost",
  log: true
