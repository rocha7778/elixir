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
        IO.puts("Response to msg #{msg} to  #{inspect caller}")
        send(caller, {:response, msg})

       msg ->IO.puts("Received  #{msg} without caller")
    end

    loop()
  end
end

pid = Server.start()
Enum.each(1..3,
 fn x -> spawn(
    fn -> IO.puts("Sending msg #{x} to  #{inspect pid}")
    response = Server.send_msg(pid,x)
    IO.puts("Response #{response}")
    end)
  end
)
