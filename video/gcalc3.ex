defmodule GCalc do
  use GenServer

  def init(param) do
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
