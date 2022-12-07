defmodule FakerTest do
  use ExUnit.Case
  doctest Faker

  test "greets the world" do
    assert Faker.hello() == :world
  end
end
