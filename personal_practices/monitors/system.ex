defmodule System do
  def start_link do

    children = [
      # The Counter is a child started via Counter.start_link(0)
      %{
        id: Counter,
        start: {Counter, :start_link, [0]}
      }
    ]

    opts = [strategy: :one_for_one, name: __MODULE__]

    Supervisor.start_link(
      children ,
      opts
    )
  end
end
