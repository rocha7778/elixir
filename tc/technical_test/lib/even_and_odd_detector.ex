defmodule EvenAndOddDetector do
  @doc """
  Even and Odd Detector

  ## Examples

      iex> EvenAndOddDetector.dector(4)
      The number introduced is even.
      :ok

  """

  def dector(number) when is_binary(number) do
    IO.puts("An error occurred: Please input a number.")
  end

  def dector(number) when number < 0 do
    IO.puts("The number introduced is negative.")
  end

  def dector(0), do: IO.puts("The number introduced is zero.")

  def dector(number) when number > 0 and is_integer(number) do
    even_or_odd(number)
  end

  def dector(_) do
    IO.puts("The input is not a number.")
  end

  @spec dector(integer) :: String.t()
  defp even_or_odd(number) do
    if rem(number, 2) == 0 do
      IO.puts("The number introduced is even.")
    else
      IO.puts("The number introduced is odd.")
    end
  end
end

# EvenAndOddDetector.dector("a")
# EvenAndOddDetector.dector("abc")
# EvenAndOddDetector.dector(3)
# EvenAndOddDetector.dector(4)
# EvenAndOddDetector.dector(0)
# EvenAndOddDetector.dector(1)
