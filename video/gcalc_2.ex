defmodule GCalc do
  use GenServer

  def start_link(), do: GenServer.start_link(__MODULE__, :ok)
  def add(a,b), do: GenServer.call(GCalc.Calculator,{:add,a,b})
  def sub(a,b), do: GenServer.call(GCalc.Calculator,{:sub,a,b})
  def mul(a,b), do: GenServer.call(GCalc.Calculator,{:mul,a,b})
  def div(a,b), do: GenServer.call(GCalc.Calculator,{:div,a,b})

  def init(:ok) do
    IO.puts("[GCalc] Iniciando GenServer")
    {:ok, 0}
  end

  def start_link() do
    GenServer.start_link(GCalc, nil, name: GCalc.Calculator)
  end

  def handle_info(msg, %{conteo: conteo}) do
    IO.puts("Reciviendo mensaje #{msg}")
    IO.puts("He sido llamado #{conteo}")
    {:noreply, %{conteo: conteo+1}}

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




children = [
  # The Stack is a child started via Stack.start_link([:hello])
  %{
    id: Caculadora,
    start: {Caculadora, :start_link, []}
  }
]

{:ok, pid} = Supervisor.start_link(children, strategy: :one_for_one)


children = [
  MyApp.Supervisor
]

Supervisor.start_link(children, strategy: :one_for_one)
