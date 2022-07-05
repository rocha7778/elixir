defmodule GCalc do
  use GenServer



  def start_link(), do: GenServer.start_link(__MODULE__, :ok, name: __MODULE__)
  def add(a,b), do: GenServer.call(__MODULE__,{:add,a,b})
  def sub(a,b), do: GenServer.call(__MODULE__,{:sub,a,b})
  def mul(a,b), do: GenServer.call(__MODULE__,{:mul,a,b})
  def div(a,b), do: GenServer.call(__MODULE__,{:div,a,b})

  def init(:ok) do
    IO.puts("[GCalc] Iniciando GenServer")
    {:ok, 0}
  end

  def handle_call({:add,a,b}, _from , state) do
    {:reply, a+b, state+1}
  end
  def handle_call({:mul,a,b}, _from , state) do
    {:reply, a*b, state+1}
  end
  def handle_call({:sub,a,b}, _from , state) do
    {:reply, a-b, state+1}
  end
  def handle_call({:div,a,b}, _from , state) do
    {:reply, a/b, state+1}
  end
end
