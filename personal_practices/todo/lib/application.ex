defmodule Todo.Application do
  use Application
  require Logger


  @impl true
  def start(_type, _args) do
    Logger.info("Ejecutando TodoCache")
    Supervisor.start_link(
      [
        Todo.Cache
      ],
      strategy: :one_for_one
    )
  end

end
