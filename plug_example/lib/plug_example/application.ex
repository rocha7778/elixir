defmodule PlugExample.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application
  require Logger

  @impl true
  def start(_type, _args) do
    children = [
      {Plug.Cowboy, scheme: :http, plug: PlugExample.Router, options: [port: cowboy_port()]},
      Metrics.Telemetry,
      {Metrics.Telemetry.ReporterState, {0, 0}},
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: PlugExample.Supervisor]
    Logger.info("Starting application... on 8080")
    Supervisor.start_link(children, opts)
  end

  defp cowboy_port, do: Application.get_env(:plug_example, :cowboy_port, 8080)
end
