defmodule MytestAppTest do
  use ExUnit.Case
  doctest MytestApp

  test "greets the world" do
    assert MytestApp.hello() == :world
  end
end
