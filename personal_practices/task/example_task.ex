long_job = fn  ->
  Process.sleep(2000)
  :some_result
end


task = Task.async(long_job)
Task.await(task)


run_query = fn query_def ->
  Process.sleep(3000)
  "#{query_def} result"
end

queries = 1..5
task = Enum.map(queries,
fn x -> Task.async(fn  ->  run_query.("query #{x}") end)  end
)

Enum.map(task, fn x -> Task.await(x) end)

test_function = fn (%{} = conf) ->
Process.sleep(2000)
IO.puts(" #{ inspect conf} result")
end

test_function.(%{a: 1})
