defmodule KeyValueStore do
  use GenServer

  @module __MODULE__
  def start do
    GenServer.start(
      KeyValueStore,
       %{a: 1},
       name: @module)
  end

  def put(key, value) do
    GenServer.cast(@module, {:put, key, value})
  end

  def get(key) do
    GenServer.call(@module, {:get, key})
  end

  def stop_server do
    GenServer.cast(@module, {:stop})
  end

  def init(map) do
    {:ok, map}
  end

  def handle_cast({:put, key, value}, state) do
    {:noreply, Map.put(state,key,value)}
  end

  def handle_cast({:stop}, state) do
    {:stop, :test_stop, state}
  end

  def handle_call({:get, key}, _, state) do
    {:reply, Map.get(state, key), state}
  end

  def handle_info(:cleanup, state) do
    IO.puts("Performing cleanup")
    {:noreply, state}
  end

  def terminate(reason, state) do
    IO.puts("Performing cleanup")
    {reason, state}
  end
end

#{:ok, pid} = KeyValueStore.start()
#KeyValueStore.put(pid, :some_key, :some_value)
#KeyValueStore.get(pid, :some_key)

#KeyValueStore.start()
#KeyValueStore.put(:some_key, :some_value)
#KeyValueStore.get(:some_key)
#KeyValueStore.stop_server()
