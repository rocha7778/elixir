defmodule RegitryTest do
  use ExUnit.Case
  doctest Regitry

  test "greets the world" do
    assert Regitry.hello() == :world
  end
end
