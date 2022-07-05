Enum.map(1..5, fn x-> run_query.("query #{x}") end)
Enum.map(1..5, fn x -> run_query.("query #{x}") end)

Enum.map(1..5, fn x -> spawn(fn -> IO.puts(run_query.("query #{x}")) end) end)

run_query =  fn query_def -> Process.sleep(2000)
"#{query_def} result" end

async_query = fn query_def -> spawn( fn -> IO.puts(run_query.(query_def)) end) end
 async_query =
  fn query_def ->
    spawn(fn -> IO.puts(run_query.(query_def)) end)
  end

  send(self(),{:message,1})
  result = receive do
    {:message, x} ->
      x + 2
  end
  IO.puts(result)


  run_query =  fn query_def -> Process.sleep(2000)
  "#{query_def} result" end

  async_query =
    fn query_self ->
      caller = self()
      spawn( fn ->
         send(caller,{:query_result,run_query.(query_self)})
      end)
    end


    Enum.map(1..5, fn x -> async_query.("#{x}") end)

    get_result = fn ->
      receive do
        {:query_result, result} -> result
      end
    end

    resutls = Enum.map(1..5, fn _ -> get_result.() end)
