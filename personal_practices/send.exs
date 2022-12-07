send(self(), {:message, "a message"})

receive do
  {:message, value} ->
    IO.inspect(value)
end

receive do
  message -> IO.inspect(message)
after
  5000 -> IO.puts("message not received")
end

Enum.each(
  1..5,
  fn i ->
    spawn(
      fn ->
        IO.puts("Sending msg ##{i}")
        response = Server.send_msg(pid, i)
        IO.puts("Response: #{response}")
    end)
  end
)
