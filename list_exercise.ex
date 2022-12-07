defmodule TestList do
  def size_list (list) do
    l = length(list)
    IO.puts("lent of #{l}")

  end

  def rango(from, to) do
    Enum.to_list(from..to)
  end

  def positive_number(list) do
    Enum.filter(list, fn x -> x >= 0 end)
  end


end
