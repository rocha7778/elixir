defmodule Server do
  def start do
    spawn(fn -> loop() end)
  end

  def send_msg(server, message) do
    IO.puts("PID  from client, this is my  server pid #{inspect(server)}")
    send(server, {self(), message})

    receive do
      {:response, response} -> response
    end
  end

  defp loop do
    receive do
      {caller, mensaje} ->
        IO.puts("PID  from myself  #{inspect(caller)}")
        Process.sleep(5_000)
        send(caller, {:response, mensaje})
    end
    loop()
  end
end


pid = Server.start()
IO.puts("PId cliente  elixir #{inspect(self())}")





Enum.each(
  1..5,
  fn i ->
    id = spawn(fn ->
      IO.puts("Sending msg ##{i}")
      response = Server.send_msg(pid, i)
      IO.puts("Response: #{response}")
    end)
    IO.puts("PId creado en el ciclo  elixir #{inspect(id)}")
  end
)
