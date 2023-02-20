defmodule Metrics.Telemetry do
  use Supervisor
  import Telemetry.Metrics

  def start_link(arg) do
    Supervisor.start_link(__MODULE__, arg, name: __MODULE__)
  end

  def init(_arg) do
    children = [
      {TelemetryMetricsPrometheus, metrics: metrics(), port: 8080 },
      {Metrics.Telemetry.CustomReporter, metrics: metrics()}
    ]

    Supervisor.init(children, strategy: :one_for_one)
  end

  defp metrics do
    [
      counter("metrics.emit.value"),
      sum("metrics.request.vale")
    ]
  end
end
