defmodule EchoServer do
  use GenServer

  def start_link(id) do
    GenServer.start_link(__MODULE__, nil, name: via_tuple(id))
    # GenServer.start_link(__MODULE__, nil, name: {:via, some_module,some_arg})
    # GenServer.start_link(__MODULE__, nil, name: {:via, Registry,{registry_name,process_kye}})
  end

  def call(id, some_request) do
    GenServer.call(via_tuple(id), some_request)
  end

  def handle_call(some_request, _, state) do
    {:reply, some_request, state}
  end

  def via_tuple(id) do
    {:via, Registry, {:my_registry, {__MODULE__, id}}}
    # {:via, some_module, some_arg}
  end
end

# GenServer.start_link(callback_module, some_arg, name: some_name)

# EchoServer.start_link("server one")
# EchoServer.call("server one", :some_request)

# EchoServer.start_link("server two")


# Registry.start_link(name: :my_registry, keys: :unique)

# spawn(fn ->
#   Registry.register(:my_registry, {:database_worker, 1}, nil)
#
#   receive do
#     msg -> IO.puts("got message #{inspect(msg)}")
#   end
# end)
#
# [{db_worker_pid, _value}] =
#   Registry.lookup(
#     :my_registry,
#     {:database_worker, 1}
#   )
#
# send(db_worker_pid, :some_message)
#
# Registry.lookup(:my_registry, {:database_worker, 1})
