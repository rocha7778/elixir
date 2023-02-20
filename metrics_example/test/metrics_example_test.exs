defmodule MetricsExampleTest do
  use ExUnit.Case
  doctest MetricsExample

  test "greets the world" do
    assert MetricsExample.hello() == :world
  end
end
