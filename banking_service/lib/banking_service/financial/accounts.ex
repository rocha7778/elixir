defmodule Financial.Account do

  use GenServer



  def start_link(_) do
    IO.puts("Starting Account service")
    GenServer.start_link(__MODULE__, nil, name: __MODULE__)
  end


  @impl GenServer
  def init(_) do
    {:ok, %{}}
  end

  @impl true
  def handle_cast({:update_account, account = %{account: number, balance: amount}}, account) do
    IO.puts("updating the account number #{number} with balance #{amount}")
    account = %{account | balance: amount  + (amount*0.3)}
    {:noreply, account}
  end

  @impl true
  def handle_call({:get_account, account_number}, _, account) do
    IO.puts("Getting account")
    account = %{account | balance: 1500}
    account = %{account | number: account_number}

    {:reply,account, account}
  end
end
