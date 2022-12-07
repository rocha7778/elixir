defmodule Todo.Database do
  use GenServer

  @db_folder "./persist"

  @pid_database __MODULE__
  def start do
    GenServer.start(__MODULE__, nil, name: @pid_database)
  end

  @impl GenServer
  def init(_) do
    File.mkdir_p!(@db_folder)
    {:ok, start_workers()}
  end

  defp start_workers() do
    for index <- 1..3, into: %{} do
      {:ok, pid} = Todo.DatabaseWorker.start(@db_folder)
      {index - 1, pid}
    end
  end

  def store(key, data) do
    key
    |> choose_worker()
    |> Todo.DatabaseWorker.store(key,data)
    #GenServer.cast(@pid_database, {:store, key, data})
  end

  def get(key) do
    key
    |> choose_worker()
    |> Todo.DatabaseWorker.get(key)
  end

  # Choosing a worker makes a request to the database server process. There we
  # keep the knowledge about our workers, and return the pid of the corresponding
  # worker. Once this is done, the caller process will talk to the worker directly.
  defp choose_worker(key) do
    GenServer.call(@pid_database, {:choose_worker, key})
  end

  @impl GenServer
  def handle_call({:choose_worker, key}, _, workers) do
    worker_key = :erlang.phash2(key, 3)
    {:reply, Map.get(workers, worker_key), workers}
  end

  #@impl GenServer
  #def handle_cast({:store, key, data}, state) do
  #  key
  #  |> file_name()
  #  |> File.write!(:erlang.term_to_binary(data))
#
  #  {:noreply, state}
  #end
#
  #@impl GenServer
  #def handle_call({:get, key}, _, state) do
  #  data =
  #    case File.read(file_name(key)) do
  #      {:ok, contents} -> :erlang.binary_to_term(contents)
  #      _ -> nil
  #    end
#
  #  {:reply, data, state}
  #end

  defp file_name(key) do
    Path.join(@db_folder, to_string(key))
  end
end
