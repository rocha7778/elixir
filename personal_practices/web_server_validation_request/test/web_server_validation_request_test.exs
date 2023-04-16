defmodule WebServerValidationRequestTest do
  use ExUnit.Case
  doctest WebServerValidationRequest

  test "greets the world" do
    assert WebServerValidationRequest.hello() == :world
  end
end
