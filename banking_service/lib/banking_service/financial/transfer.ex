defmodule Financial.Transfer do
  use GenServer

  def start_link(_) do
    IO.puts("Starting Transfer service")
    GenServer.start_link(__MODULE__, nil, name: __MODULE__)
  end

  @impl GenServer
  def init(_) do
    {:ok, %{}}
  end

  @impl true
  def handle_cast({:transfer_account,  [account_from = %{account: number, balance: amount}, account_to= %{account: number, balance: amount}]}, account) do
    IO.puts("trasnfer account balance from #{account_from.number} to  #{amount}")
    account = %{account | balance: account_from.balance + account_to.balance}
    {:noreply, account}
  end

end
