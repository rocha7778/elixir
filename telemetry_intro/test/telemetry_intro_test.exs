defmodule TelemetryIntroTest do
  use ExUnit.Case
  doctest TelemetryIntro

  test "greets the world" do
    assert TelemetryIntro.hello() == :world
  end
end
