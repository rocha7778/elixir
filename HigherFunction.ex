defmodule Print do
  def print() do
    Enum.each(
    [1,2,3],
    fn x -> IO.puts(x) end
    )

  end

end
