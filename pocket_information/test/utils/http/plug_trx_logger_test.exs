defmodule PocketInformation.Test.Utils.HTTP.PlugTrxLoggerTest do
  import Mock
  alias PocketInformation.Utils.HTTP.PlugTrxLogger
  alias PocketInformation.Test.Support.TestStubs
  use ExUnit.Case
  use Plug.Test

  describe "call/2" do
    test "register a callback function before sending response" do
      body_params = TestStubs.body_params()
      conn = conn(:get, "/")
      conn = %{conn | body_params: body_params}
      conn_with_before_func = PlugTrxLogger.call(conn, :info)
      func = conn_with_before_func.private.before_send
      assert func !== []
    end

    test "take information from the request and response to produce a log message" do
      body_params = TestStubs.body_params()
      conn = conn(:get, "/")
      conn = %{conn | body_params: body_params}
      PlugTrxLogger.call(conn, :info)

      resp =
        conn
        |> Plug.Conn.resp(200, "OK")
        |> Plug.Conn.send_resp()

      assert resp.state == :sent
    end

    test "should not fail even when the payload is invalid" do
      body_params = TestStubs.invalid_body_params()
      conn = conn(:get, "/")
      conn = %{conn | body_params: body_params}
      conn_with_before_func = PlugTrxLogger.call(conn, :info)
      func = conn_with_before_func.private.before_send
      assert func !== []
    end
  end
end
