defmodule PocketInformation.Application do
  @moduledoc """
  Main entry point of the app.
  """

  use Application

  require Logger

  alias PocketInformation.Config.AppConfig
  alias PocketInformation.EntryPoints.Http.Rest.ApiRestController
  alias PocketInformation.Utils.HTTP.CowboyUtils
  alias PocketInformation.Adapters.Cache.CacheImpl
  alias PocketInformation.Utils.Metrics.Telemetry

  @impl true
  def start(_type, _args) do
    env = Application.get_env(:pocket_information, :env)

    CacheImpl.start()

    cowboy_child_spec = CowboyUtils.build_child_spec(env, ApiRestController)

    children =
      [
        {
          Mongo,
          [
            name: :mongodb,
            database: AppConfig.get_db_name(),
            hostname: AppConfig.get_db_host(),
            port: AppConfig.get_db_port(),
            username: AppConfig.get_db_user(),
            password: AppConfig.get_db_password(),
            auth_source: AppConfig.db_auth_source(),
            pool_size: AppConfig.get_db_pool_size(),
            ssl: AppConfig.db_use_ssl(),
            ssl_opts: [
              verify: AppConfig.db_verify_cer(),
              cacertfile: AppConfig.db_castore(),
              keyfile: AppConfig.db_private_certificate(),
              certfile: AppConfig.db_public_certificate(),
            ]
          ]
        },
        Telemetry
      ] ++ cowboy_child_spec

    opts = [strategy: :one_for_one, name: __MODULE__]
    Logger.info("Ejecutando Pocket Information API")

    Supervisor.start_link(children, opts)
  end
end
