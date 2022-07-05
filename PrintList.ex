defmodule PrintList do
  def print([]), do: IO.puts("List is empty")
  def print([head|tail]), do: IO.puts(head) + print(tail)
end
