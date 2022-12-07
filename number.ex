defmodule Test do
  def num(1), do: IO.puts(1)
  def num(x) when is_number(x) and x < 0, do: :negative
  def num(variable) when is_number(variable) and variable > 0 do
    IO.puts(variable)
    num(variable - 1)
  end
end
