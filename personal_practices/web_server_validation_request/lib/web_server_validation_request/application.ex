defmodule WebServerValidationRequest.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do

    children = [
      {
      Plug.Cowboy,
      scheme: :http,
      plug: MyApp,
      options: [port: get_port()]}
    ]



    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: WebServerValidationRequest.Supervisor]
    Supervisor.start_link(children, opts)
  end

  defp get_port do
    Application.get_env(:web_server_validation_request, :port, 8080)
  end
end
