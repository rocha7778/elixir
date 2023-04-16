defmodule StructTestTest do
  use ExUnit.Case
  doctest StructTest

  test "greets the world" do
    assert StructTest.hello() == :world
  end
end
