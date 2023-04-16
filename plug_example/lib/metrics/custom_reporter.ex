defmodule Metrics.Telemetry.CustomReporter do
  use GenServer

  alias Metrics.Telemetry.ReporterState
  alias Telemetry.Metrics

  def start_link(metrics: metrics) do
    GenServer.start_link(__MODULE__, metrics, name: __MODULE__)
  end

  @impl true
  def init(metrics) do
    Process.flag(:trap_exit, true)

    groups = Enum.group_by(metrics, & &1.event_name)

    for {event, metrics} <- groups do
      id = {__MODULE__, event, self()}
      :telemetry.attach(id, event, &__MODULE__.handle_event/4, metrics)
    end
    keys = Map.keys(groups)

    IO.inspect(keys)
    {:ok, keys}
  end

  def handle_event(event_name, measurements, metadata, metrics) do

    #IO.inspect(event_name, label: :event_name)
    #IO.inspect(measurements, label: :measurements)
    #IO.inspect(metadata, label: :metadata)
    #IO.inspect(metrics, label: :metrics)

    metrics
    |> Enum.map(&handle_metric(&1, measurements, metadata))


  end

  defp handle_metric(%Metrics.Counter{} = metric, _measurements, _metadata) do
    ReporterState.increment()

    current_value = ReporterState.value()

    IO.puts("Metric: #{metric.__struct__}. Current value: #{inspect(current_value)}")
  end

  defp handle_metric(%Metrics.Sum{} = metric, %{value: value}, _metadata) do
    ReporterState.sum(value)

    current_value = ReporterState.value()

    IO.puts("Metric: #{metric.__struct__}. Current value: #{inspect(current_value)}")
  end

  defp handle_metric(metric, _measurements, _metadata) do
    IO.puts("Unsupported metric: #{metric.__struct__}")
  end

  @impl true
  def terminate(_, events) do
    for event <- events do
      :telemetry.detach({__MODULE__, event, self()})
    end

    :ok
  end
end
