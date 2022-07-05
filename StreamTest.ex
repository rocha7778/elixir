defmodule TestStream do
  def test(stream) do
    stream|>
    Stream.map(fn x->2*x end)
    Enum.to_list(stream)
  end

  def printEmploye(list) do
    list|>
    Stream.with_index|>
    (
      Enum.each(
        fn {employee, index} -> IO.puts("#{index+1}. #{employee}") end
      )
    )
  end

  def calculate_sqrt(list) do

    list|>
    Stream.filter(fn x -> is_number(x) and x > 0 end)|>
    Stream.map(fn x->{x, :math.sqrt(x)} end)|>
    Stream.with_index |>
    Enum.each(
      fn {{input,result},index}-> IO.puts("#{index+1}. sqrt(#{input}= #{result})") end
    )

  end
end
