defmodule TestReleaseTest do
  use ExUnit.Case
  doctest TestRelease

  test "greets the world" do
    assert TestRelease.hello() == :world
  end
end
