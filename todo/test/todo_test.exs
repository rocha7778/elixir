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

      request =  %{
        body: nil,
        connection: [],
        content_length: nil,
        data_buffer: [],
        headers_buffer: [],
        method: "GET",
        ref: "#Reference<0.1291779294.3723493381.1180>",
        state: :status,
        status: nil,
        transfer_encoding: [],
        version: nil
      }

    map = elem(conn,1)
    map = %{map | request: request}
    conn_request = {:ok , map, "#Reference<0.1291779294.3723493381.1180>"}

      with_mocks ([
        {Mint.HTTP, [], [connect: fn (_protocol, _host, _port) -> conn end ]},
        {Mint.HTTP, [], [request: fn (conn, _method = "GET", _path = "/users", _headers=[],nil) -> conn_request end ]}

      ]) do

       assert conn_request == MintTest.test()
      end
    end

  end

end
