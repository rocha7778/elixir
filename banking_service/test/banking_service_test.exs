defmodule BankingServiceTest do
  use ExUnit.Case
  doctest BankingService

  test "greets the world" do
    assert BankingService.hello() == :world
  end
end
