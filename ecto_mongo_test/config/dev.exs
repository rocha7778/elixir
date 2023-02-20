import Config

config :logger, :console, level: :debug, format: "[$level] [$date] [$time] $message\n\n"


# Database connection
config :postgress_test, CreditCardInformation.Ecto.Repo,
       adapter: Mongo.Ecto,
       database: "depositoa",
       hostname: "localhost",
       log: true



config :ecto_mongo_test, :ecto_repos, [
  CreditCardInformation.Ecto.Repo
]
       #pool: DBConnection.ConnectionPool,
       #pool_size: 5

# {:ok, pid} = Postgrex.start_link(hostname: "localhost", username: "postgres", password: "123456", database: "experimentos")
# Postgrex.query(pid, "select * from emision_tarjeta_credito;", [])
