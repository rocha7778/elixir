defmodule Stack do
  use GenServer

  alias __MODULE__, as: Stack

  def start_link(state) do
    GenServer.start_link(Stack state, name: Stack)
  end

  def pop([head | tail]), do: GenServer.call(Stack, {:pop,[head | tail]}) end
  ## Callbacks

  @impl true
  def init(stack) do
    {:ok, stack}
  end

  @impl true
  def handle_call(:pop, _from, [head | tail]) do
    {:reply, head, tail}
  end



  @impl true
  def handle_cast({:push, head}, tail) do
    {:noreply, [head | tail]}
  end
end

#send({:push,0},1)
