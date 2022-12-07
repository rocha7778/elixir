target_pid =
  spawn(fn ->
    Process.sleep(5000)
  end)

Process.monitor(target_pid)

receive do
  msg -> IO.inspect(msg)
end
