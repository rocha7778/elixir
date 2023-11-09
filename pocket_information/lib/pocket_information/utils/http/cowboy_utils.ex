defmodule PocketInformation.Utils.HTTP.CowboyUtils do
  alias PocketInformation.Config.AppConfig
  require Logger

  def build_child_spec(:prod, plug) do
    Logger.debug("Setting up child spec for cowboy mtls")

    [
      {Plug.Cowboy,
       scheme: :https,
       plug: plug,
       options: [
         port: AppConfig.get_port(),
         cipher_suite: :strong,
         password: AppConfig.server_private_passphrase(),
         certfile: AppConfig.server_public_certificate_path(),
         keyfile: AppConfig.server_private_key_path(),
         verify: :verify_peer,
         fail_if_no_peer_cert: true,
         cacertfile: AppConfig.castore_path()
       ]}
    ]
  end

  def build_child_spec(:dev, plug) do
    [{Plug.Cowboy, scheme: :http, plug: plug, options: [port: AppConfig.get_port()]}]
  end

  def build_child_spec(:test, _plug), do: []
end
