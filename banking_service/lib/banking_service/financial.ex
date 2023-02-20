defmodule Financial do

  alias Financial.Account
  alias Financial.Transfer

  use GenServer

  def start_link(name) do
    IO.puts("Starting financial module for #{name}.")
    GenServer.start_link(__MODULE__,name, name: Financial)
  end


  @impl true
  def init(initial_state) do
     Account.start_link(initial_state)
     Transfer.start_link(initial_state)
    {:ok, initial_state}
  end

  @impl true
  def handle_cast({:send_notification, email}, state) do
    IO.puts("Sending notification to  #{email}.")
    {:noreply, state}
  end

  @impl true
  def handle_call({:calculate_tax, taxes}, _, state) do
    IO.puts("calculating taxes")
    {:reply,taxes, state}
  end

  def child_spec(_) do
    %{
      id: __MODULE__,
      start: {Financial, :start_link, ["financialProx"]},
      name: __MODULE__
    }
  end


end
