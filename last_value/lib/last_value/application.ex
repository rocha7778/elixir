defmodule LastValue.Application do
  use Application
  @impl true
  def start(_type, _args) do
    children = [Metrics.Telemetry]
    opts = [strategy: :one_for_one, name: LastValue.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
