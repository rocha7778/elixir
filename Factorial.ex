defmodule Fact do
  def fact(0), do: 1
  def fact(n) when n>0 and is_number(n), do: n*fact(n-1)
end
