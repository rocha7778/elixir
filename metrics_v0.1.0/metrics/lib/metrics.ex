defmodule Metrics do
  def emit(value) do
    :telemetry.execute([:metrics, :emit], %{value: value})
    :telemetry.execute([:metrics, :request], %{value: value})
  end
end

# Metrics.emit(4)
