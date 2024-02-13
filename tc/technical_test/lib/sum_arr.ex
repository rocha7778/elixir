defmodule SumArr do
  @doc """
  Sum Arr

  ## Examples

      iex> SumArr.sum([1,2,3])
      6

  """
  @spec sum([number()]) :: number()
  def sum([]), do: 0

  def sum([head | tail]) do
    head + sum(tail)
  end
end

# SumArr.sum([1,2,3])
