defmodule TechnicalTestTest do
  use ExUnit.Case
  doctest TechnicalTest

  test "greets the world" do
    assert TechnicalTest.hello() == :world
  end
end
