defmodule Sender do

  use GenServer


  def start_link(name) do
    IO.puts("Starting Sender for #{name}.")
    GenServer.start_link(__MODULE__, name, name: __MODULE__)
  end

  @impl true
  def init(initial_state) do
    {:ok, initial_state}
  end


  @impl true
  def handle_cast({:sending_email, email}, state) do
    IO.puts("Sending email  #{email}")
    {:noreply, state}
  end

  @impl true
  def handle_call({:get, email}, _, state) do
    IO.puts("getting eamil from email servers")
    {:reply, email, state}
  end

  def child_spec(_) do
    %{
      id: __MODULE__,
      start: {Sender, :start_link, ["easyMail"]},
      name: __MODULE__
    }
  end

  def throw_a_faild do
     raise ("failed")
  end
end


# Sender.throw_a_faild
# Sender.handle_call({:get, "rocha7778@hotmail.com"}, :pid, "email")
