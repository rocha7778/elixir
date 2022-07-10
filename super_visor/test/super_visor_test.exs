defmodule SuperVisorTest do
  use ExUnit.Case
  doctest SuperVisor

  test "greets the world" do
    assert SuperVisor.hello() == :world
  end

  test "sum 2+2 == 4" do
    assert SuperVisor.add(2,2) == 4
  end
end
