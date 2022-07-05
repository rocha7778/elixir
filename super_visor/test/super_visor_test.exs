defmodule SuperVisorTest do
  use ExUnit.Case
  doctest SuperVisor

  test "greets the world" do
    assert SuperVisor.hello() == :world
  end
end
