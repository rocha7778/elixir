run_query = fn query_def ->
   Process.sleep(2000)
   "#{query_def} result"
end

Enum.map(1..5, fn x -> run_query.("query #{x}") end)

spawn(fn -> IO.puts(run_query.("query1")) end)


async_query = fn query_def ->
              spawn(fn -> IO.puts(run_query.(query_def)) end)
end


Enum.each(1..5, &async_query.("query #{&1}"))


Registry.start_link(keys: :unique, name: :my_registry)

spawn(fn ->
   Registry.register(:my_registry, {:database_worker,1},nil)

   receive do
      message -> IO.puts("got mesasge #{inspect(message)}")
   end
end)


[{db_worker_pid, _value}] = Registry.lookup(:my_registry, {:database_worker,1})

send(db_worker_pid, :some_message)
