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

