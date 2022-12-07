defmodule Calculadora do
  use GenServer

  alias __MODULE__, as: Calcular
  alias Cal

  def start_link(), do: GenServer.start_link(Calcular, :ok, name: Calcular)

  def child_spec(_arg) do
    %{
      id: Calcular,
      start: {Calcular, :start_link, []}
    }
  end
  @expiry_idle_timeout :timer.seconds(10)

  def init(:ok) do
    IO.puts("[GCalc] Iniciando GenServer")
    {:ok, 0, @expiry_idle_timeout}
  end


  def add(a,b), do: GenServer.call(Calcular,{:add,a,b})
  def sub(a,b), do: GenServer.call(Calcular,{:sub,a,b})
  def mul(a,b), do: GenServer.call(Calcular,{:mul,a,b})
  def div(a,b), do: GenServer.call(Calcular,{:div,a,b})

  def handle_call({:add,a,b}, _from , state) do
    {uSecs, result} = :timer.tc(Cal, :add, [a,b])
    
    IO.inspect(uSecs, label: :micro_second)
    IO.inspect(result, label: :result)
    {:reply, Cal.add(a,b), state+1 , @expiry_idle_timeout}
  end

  def handle_call({:mul,a,b}, _from , state) do
    {:reply, Cal.mul(a,b), state+1, @expiry_idle_timeout}
  end
  def handle_call({:sub,a,b}, _from , state) do
    {:reply, Cal.sub(a,b), state+1, @expiry_idle_timeout}
  end
  def handle_call({:div,a,b}, _from , state) do
    {:reply, Cal.div(a,b), state+1, @expiry_idle_timeout}
  end


  def handle_info(:timeout, state) do
    IO.puts("Stopping server for state #{state}")
    {:stop, :normal, state}
  end
end
