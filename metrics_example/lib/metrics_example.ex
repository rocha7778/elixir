defmodule MetricsExample do
  def emit(value) do
    :telemetry.execute([:metrics, :emit], %{value: value})
    :telemetry.execute([:db, :query], %{value: value})
  end
end

# emitir un evento
# MetricsExample.emit(1)

# emitir 100 eventos
# 1..100|>Enum.each(MetricsExample.emit(&1))
