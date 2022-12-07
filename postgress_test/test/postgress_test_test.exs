defmodule PostgressTestTest do
  use ExUnit.Case
  doctest PostgressTest

  test "greets the world" do
    assert PostgressTest.hello() == :world
  end
end
