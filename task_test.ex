




task = Task.async(long_job)
Task.await(task)

run_query =
  fn query_def ->
    Process.sleep(2000)
    "#{query_def} result"
  end

  queries = 1..5

  tasks = Enum.map(
    queries,
    (fn query_def ->  Task.async(fn -> run_query.("query #{query_def}") end) end)
  )

  Enum.map(tasks, fn task -> Task.await(task) end)
