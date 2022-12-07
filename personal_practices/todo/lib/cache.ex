defmodule Todo.Cache do
  use GenServer

  @pid_cache __MODULE__
  #def start do
  #  GenServer.start(__MODULE__, nil, name: @pid_cache)
  #end

  def start_link(_) do
    IO.puts("Starting to-do cache")
    GenServer.start(__MODULE__, nil, name: @pid_cache)
  end

  @impl GenServer
  def init(_) do
    Todo.Database.start()
    {:ok, %{}}
  end

  def server_process(todo_list_name) do
    GenServer.call(@pid_cache, {:server_process, todo_list_name})
  end


  @impl GenServer
  def handle_call({:server_process, todo_list_name}, _from, todo_servers) do
    case Map.fetch(todo_servers, todo_list_name) do
      {:ok, pid_todo_server} -> {:reply, pid_todo_server, todo_servers}
      :error -> create_new_todo_server(todo_servers, todo_list_name)
    end
  end

  defp create_new_todo_server(todo_servers, todo_list_name) do
    {:ok, new_server} = Todo.Server.start(todo_list_name)
    {:reply,new_server, Map.put(todo_servers,todo_list_name,new_server)}
  end
end

# {:ok, pid} = Todo.Cache.start()


# rocha_list = Todo.Cache.server_process("rocha_lis")
# bob_list = Todo.Cache.server_process("bob_lis")

# INSERTION
# Todo.Server.add_entry(rocha_list, %{date: ~D[2022-11-13], age: 20})
# Todo.Server.add_entry(bob_list, %{date: ~D[2022-11-13], age: 20})

# READING
#Todo.Server.entries(rocha_list, ~D[2022-11-13])
