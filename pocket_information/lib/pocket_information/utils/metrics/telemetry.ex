defmodule PocketInformation.Utils.Metrics.Telemetry do
  use Supervisor
  import Telemetry.Metrics

  def start_link(arg) do
    Supervisor.start_link(__MODULE__, arg, name: __MODULE__)
  end

  def init(_arg) do
    children = [
      {TelemetryMetricsPrometheus,
       metrics: metrics(), port: Application.get_env(:pocket_information, :port_to_expose_metrics)}
    ]

    Supervisor.init(children, strategy: :one_for_one)
  end

  defp metrics do
    [
      last_value(
        "pocket.http.response.stop.duration",
        event_name: [:http, :response],
        measurement: :value,
        tags: [
          :method,
          :path,
          :status,
          :status_desc,
          :event_type,
          :message_id,
          :systemId,
          :request_ending_time
        ],
        unit: {:microsecond, :millisecond},
        description: "metrica para medir el tiempo de respuesta de un request"
      ),
      counter(
        "pocket.http.response.stop.counter",
        event_name: [:http, :response, :counter],
        tags: [
          :method,
          :path,
          :status,
          :status_desc,
          :event_type
        ],
        description: "metrica para contar el numero de repuestas obtenidas"
      ),
      last_value(
        "pocket.http.request.stop.duration",
        event_name: [:http, :request],
        measurement: :value,
        tags: [:method, :path, :event_type, :message_id, :systemId, :request_start_time],
        description: "metrica para registrar los request"
      ),
      counter("pocket.http.request.stop.counter",
        event_name: [:http, :request, :counter],
        tags: [:method, :path, :event_type],
        measurement: :value,
        description: "metrica para contar el numero de request realizados"
      ),
      last_value("pocket.vm.memory.total",
        event_name: [:vm, :memory],
        unit: {:byte, :megabyte},
        description:
          "Esta metrica devuelve la cantidad total de memoria disponible en la maquina virtual de Elixir en megabyte"
      ),
      last_value("pocket.vm.memory.processes",
        event_name: [:vm, :memory],
        unit: {:byte, :megabyte},
        description:
          "Envía un evento con la cantidad de memoria asignada actualmente para los procesos en megabyte"
      ),
      last_value("pocket.vm.total_run_queue_lengths.total",
        event_name: [:vm, :total_run_queue_lengths],
        description:
          "Esta metrica cuenta el numero total de procesos que estan actualmente bloqueados en todas las colas de ejecución en la maquina virtual de Elixir"
      ),
      last_value("pocket.vm.total_run_queue_lengths.cpu",
        event_name: [:vm, :total_run_queue_lengths],
        description:
          "Esta metrica cuenta el numero total de procesos que estan actualmente bloqueados en la cola de ejecución de la CPU en la maquina virtual de Elixir"
      ),
      last_value("pocket.vm.total_run_queue_lengths.io",
        event_name: [:vm, :total_run_queue_lengths],
        description:
          "Esta metrica cuenta el numero total de procesos que estan actualmente bloqueados en la cola de ejecución de entrada/salida en la maquina virtual de Elixir"
      ),
      last_value("pocket.vm.system_counts.process_count",
        event_name: [:vm, :system_counts],
        description:
          "Mide el numero de procesos que se estan ejecutando actualmente en el sistema de la maquina virtual"
      ),
      last_value("pocket.vm.system_counts.port_count",
        event_name: [:vm, :system_counts],
        description: "Cuenta el número de puertos abiertos en el sistema"
      )
    ]
  end
end
