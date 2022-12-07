defmodule Counter do
  use GenServer

  require Logger

  def start_link(arg) when is_integer(arg) do
    GenServer.start_link(__MODULE__, arg, name: __MODULE__)
  end

  def child_spec(_init_value) do
    %{
      id: Counter,
      start: {Counter, :start_link, [0]}
    }
  end

  ## Callbacks

  @impl true
  def init(counter) do
    Logger.info("Ejecutando Counter")
    {:ok, counter}
  end

  @impl true
  def handle_call(:get, _from, counter) do
    {:reply, counter, counter}
  end

  def handle_call({:bump, value}, _from, counter) do
    {:reply, counter, counter + value}
  end
end
