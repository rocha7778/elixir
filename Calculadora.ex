defmodule Calculadora do

  def div(_a,0) do
    IO.puts("No se puede dividir entre cero")
  end
  def div(a,b) do
    a/b
  end

end
