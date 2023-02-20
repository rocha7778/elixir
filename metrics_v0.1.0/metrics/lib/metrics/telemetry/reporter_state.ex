defmodule Metrics.Telemetry.ReporterState do
  use Agent

  def start_link(initial_value) do
    Agent.start_link(fn -> initial_value end, name: __MODULE__)
  end

  def value do
    Agent.get(__MODULE__, fn value -> value end)
  end

  def increment do
    Agent.update(__MODULE__, (fn {count, sum} -> {count + 1, sum} end))
  end

  def sum(value) do
    Agent.update(__MODULE__, (fn {count, sum} -> {count, sum + value} end))
  end

end

# Metrics.Telemetry.ReporterState.value
# Metrics.Telemetry.ReporterState.increment
