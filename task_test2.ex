defmodule TaskTest2 do
  def task1() do
    fn ->
      Process.sleep(2000)
      :some_result
    end
  end
end
