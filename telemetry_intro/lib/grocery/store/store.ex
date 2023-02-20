defmodule TelemetryIntro.Grocery.Store do
  def sale(product, quantity, amount) do
    total = quantity * amount

    :telemetry.execute(
      [:grocery, :store, :sale],
      %{total: total},
      %{product: product}
    )


    "Sold #{product}: #{quantity} units at #{amount} each. Total #{total}"
  end
end
