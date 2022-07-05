defmodule ConcurrentTest do

  def testNormal() do

   run_query =  fn query_def -> Process.sleep(2000)
    "#{query_def} result" end

    Enum.map(1..5, run_query.("aquery1"))
  end
end
