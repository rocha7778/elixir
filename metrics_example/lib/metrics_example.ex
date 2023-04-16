defmodule MetricsExample do
  @http_verbs ["GET", "PUT", "POST", "DELETE"]

  def emit(value) do
    :telemetry.execute([:metrics, :emit], %{value: value})
    :telemetry.execute([:db, :query], %{value: value})
    :telemetry.execute([:http, :request, :stop], %{value: value} , %{method: get_random_http_methods()})
  end

  def get_random_http_methods do
    Enum.random(@http_verbs) |> String.upcase()
  end
end

# emitir un evento
# MetricsExample.emit(1)

# emitir 100 eventos
# 1..100|>Enum.each(MetricsExample.emit(&1))
