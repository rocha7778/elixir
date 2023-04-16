defmodule Metrics.Telemetry do
  use Supervisor
  import Telemetry.Metrics

  def start_link(arg) do
    Supervisor.start_link(__MODULE__, arg, name: __MODULE__)
  end

  def init(_arg) do
    children = [
      {TelemetryMetricsPrometheus, metrics: metrics(), port: 8081},
    ]

    Supervisor.init(children, strategy: :one_for_one)
  end

  defp metrics do
    [
      last_value("http.response.stop.duration", event_name: [:http, :response], measurement: :value),
      counter("http.response.stop.counter", event_name: [:http, :response], measurement: :value),

      counter("http.request.stop.counter", event_name: [:http, :request], measurement: :value),
      last_value("http.request.stop.duration", event_name: [:http, :request], measurement: :value),
    ]
  end
end
