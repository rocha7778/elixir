defmodule ListHelper do
 def sum([]), do: 0
 def sum([head|tail]), do: head + sum(tail)
end


ListHelper.sum([1, 2, 3])
