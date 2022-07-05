defmodule Server do
  def start do
    spawn(fn -> loop() end)
  end

  def send_msg(server, message) do
    send(server, {self(), message})

    receive do
      {:response, response} -> response
    end
  end

  defp loop do
    receive do
      {caller, msg} ->
        Process.sleep(1000)
        send(caller, {:response, msg})
    end

    loop()
  end
end

pid = Server.start()
Enum.each(1..3,
  fn x -> spawn(
    fn -> IO.puts("Sending msg #{x}")
    response = Server.send_msg(pid,x)
    IO.puts("Response #{response}")
    end)
  end
)
