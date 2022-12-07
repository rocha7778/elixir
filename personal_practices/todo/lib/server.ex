defmodule Todo.Server do
  use GenServer

  def start(name) do
    GenServer.start(__MODULE__, name)
  end

  def add_entry(pid_todo_server, new_entry) do
    GenServer.cast(pid_todo_server, {:add_entry, new_entry})
  end

  def entries(pid_todo_server, date) do
    GenServer.call(pid_todo_server, {:entries, date})
  end

  @impl GenServer
  def init(name) do
    {:ok, {name, Todo.Database.get(name) || Todo.List.new()}}
  end

  @impl GenServer
  def handle_cast({:add_entry, new_entry}, {name, todo_list}) do
    new_list = Todo.List.add_entry(todo_list, new_entry)
    Todo.Database.store(name, new_list)
    {:noreply, {name, new_list}}
  end

  @impl GenServer
  def handle_call({:entries, date}, _, {name, todo_list}) do
    {
      :reply,
      Todo.List.entries(todo_list, date),
      {name, todo_list}
    }
  end
end
