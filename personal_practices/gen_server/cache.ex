defmodule Todo.Cache do
  use GenServer

  def start do
    GenServer.start(__MODULE__, nil)
  end

  def server_process(cache_pid, todo_list_name) do
    GenServer.call(cache_pid, {:server_process, todo_list_name})
  end

  @impl GenServer
  def init(_) do
    {:ok, %{}}
  end

  @impl GenServer
  def handle_call({:server_process, todo_list_name}, _from, todo_servers) do
    case Map.fetch(todo_servers, todo_list_name) do
      {:ok, pid_todo_server} -> {:reply, pid_todo_server, todo_servers}
      {:error} -> create_new_todo_server(todo_servers, todo_list_name)
    end
  end

  defp create_new_todo_server(todo_servers) do
    {:ok, new_server} = Todo.Server.start()
    {:reply,new_server, Map.put(todo_servers,todo_list_name,new_server)}
  end
end

# {:ok, pid} = Todo.Cache.start()
#
# Enum.each(
#  1..100_000,
#  fn index ->
#    Todo.Cache.server_process(cache, "to-do list #{index}")
#  end
# )

# rocha_list = Todo.Cache.server_process(pid, "rocha_lis")
# bob_list = Todo.Cache.server_process(pid, "bob_lis")
