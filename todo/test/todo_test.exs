defmodule TodoTest do
  alias MintTest

  import Mock
  use ExUnit.Case
  doctest Todo

  test "greets the world" do
    assert Todo.hello() == :world
  end

  describe "test_post" do
    test "two modules" do

      conn = {:ok,
      %Mint.HTTP1{
        buffer: "",
        host: "localhost",
        mode: :active,
        port: 3000,
        private: %{},
        proxy_headers: [],
        request: nil,
        requests: {[], []},
        scheme_as_string: "http",
        socket: "#Port<0.5>",
        state: :open,
        streaming_request: nil,
        transport: Mint.Core.Transport.TCP
      }}

      with_mocks ([
        {Mint.HTTP, [], [connect: fn (_protocol, _host, _port) -> conn end ]}

      ]) do

       assert conn == MintTest.test()
      end
    end

  end

end
