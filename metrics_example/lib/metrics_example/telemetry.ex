defmodule MetricsExample.Telemetry do
  use Supervisor
  import Telemetry.Metrics

  def start_link(arg) do
    Supervisor.start_link(__MODULE__, arg, name: __MODULE__)
  end

  def init(_arg) do
    children = [
      {TelemetryMetricsPrometheus, metrics: metrics(), port: 8080}
    ]

    Supervisor.init(children, strategy: :one_for_one)
  end

  defp metrics do
    [
      counter("metrics.emit.count", event_name: [:metrics, :emit], measurement: :value, description: "metrica para contar el numero de eventos"),
      counter("db.query.count", event_name: [:db, :query], measurement: :value, description: "metrica para contar el numero de veces que se realiza una query a una base de datos")
    ]
  end
end
