defmodule Concurrencia do
  def saludar(x) do
    receive do
      x -> IO.puts("Hola #{x}")
    end
  end
end
