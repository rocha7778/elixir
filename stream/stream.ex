defmodule StreamTeas do
  def testEager do
    1..3
    |>Enum.map(fn x -> IO.inspect(x) end)
    |>Enum.map(fn x ->(x*2) end)
    |>Enum.map(fn x -> IO.inspect(x) end)
  end

  def test_lazy do

    stream = 1..3
    |>Stream.map(fn x -> IO.inspect(x) end)
    |>Stream.map(fn x ->(x*2) end)
    |>Stream.map(fn x -> IO.inspect(x) end)

    Enum.to_list(stream)
  end
end
