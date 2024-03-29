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
      counter("metrics.emit.count",
        event_name: [:metrics, :emit],
        measurement: :value,
        description: "metrica para contar el numero de eventos"
      ),
      counter("db.query.count",
        event_name: [:db, :query],
        measurement: :value,
        description:
          "metrica para contar el numero de veces que se realiza una query a una base de datos"
      ),
      last_value(
        "http.request.stop.duration",
        event_name: [:http, :request, :stop],
        measurement: :value,
        tags: [:method, :path],
        unit: {:native, :millisecond}
      ),
      last_value("vm.memory.total", unit: {:byte, :megabyte}),
      last_value("vm.total_run_queue_lengths.total"),
      last_value("vm.total_run_queue_lengths.cpu"),
      last_value("vm.total_run_queue_lengths.io"),
      last_value("vm.system_counts.process_count")
    ]
  end
end
