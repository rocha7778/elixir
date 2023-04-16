defmodule Metrics.Telemetry do
  use Supervisor
  import Telemetry.Metrics

  def start_link(arg) do
    Supervisor.start_link(__MODULE__, arg, name: __MODULE__)
  end

  def init(_arg) do
    children = [
      {TelemetryMetricsPrometheus, metrics: metrics(), port: 8081},
      {Metrics.Telemetry.CustomReporter, metrics: metrics()}
    ]

    Supervisor.init(children, strategy: :one_for_one)
  end

  defp metrics do
    [
      counter("http.request.start", event_name: [:http, :request, :start], measurement: :value),
      counter("http.request.stop", event_name: [:http, :request, :stop], measurement: :value),
      last_value("http.request.stop", event_name: [:http, :request, :stop], measurement: :duration)
    ]
  end
end
