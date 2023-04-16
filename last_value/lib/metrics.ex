defmodule Metrics do
  def emit(value) do
    :telemetry.execute([:http, :response], %{value: value})
    :telemetry.execute([:http, :request], %{value: value})
  end
end

# metrics_emit_value_counter
# http_request_stop_sum
# Metrics.emit(1)

# 1..100|>Enum.each(Metrics.emit(&1))
