defmodule TelemetryIntro do
  use Application

  def start(_type, _args) do
    TelemetryIntro.Metrics.Instrumenter.setup()

    children = []
    opts = [strategy: :one_for_one, name: Metrics.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
