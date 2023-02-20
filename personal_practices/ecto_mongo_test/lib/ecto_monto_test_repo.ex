defmodule MyApp.Repo do
  use Ecto.Repo,
    otp_app: :ecto_mongo_test,
    adapter: Mongo.Ecto
end
