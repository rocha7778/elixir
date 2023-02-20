defmodule SendServer do
  use GenServer

  @impl true
  def init(args) do
    IO.puts("Received arguments: #{inspect(args)}")
    max_retries = Keyword.get(args, :max_retries, 5)
    state = %{emails: [], max_retries: max_retries}
    {:ok, state}
  end

  @impl true
  def handle_call(:get_state, _from, state) do
    {:reply, state, state}
  end

  @impl true
  def handle_cast({:send, email}, state) do
    status =
      case Sender.send_email(email) do
        {:ok, :email_send} -> "sent"
        :error -> :failed
      end

    emails = [%{email: email, status: status, retries: 0}] ++ state.emails
    {:noreply, Map.put(state, :emails, emails)}
  end
end

#  {:ok, pid} = GenServer.start(SendServer, [max_retries: 1])
#  GenServer.call(pid, :get_state)
#  GenServer.cast(pid, {:send, "hello@world.com"})
#  GenServer.cast(pid, {:send, "carlos@world.com"})
#  GenServer.cast(pid, {:send, "rocha@world.com"})
