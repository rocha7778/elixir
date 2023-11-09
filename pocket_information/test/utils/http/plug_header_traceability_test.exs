defmodule PocketInformation.Test.Utils.HTTP.PlugHeaderTraceabilityTest do
  import Mock
  alias PocketInformation.Utils.HTTP.PlugHeaderTraceability
  alias PocketInformation.Test.Support.TestStubs
  alias PocketInformation.Utils.DataTypeUtils
  use ExUnit.Case
  use Plug.Test

  describe "call/2" do
    test "should add message_id in the header connection" do
      header_without_message_id = TestStubs.header_without_message_id()

      conn = conn(:get, "/")
      conn = %{conn | req_headers: header_without_message_id}
      conn = PlugHeaderTraceability.call(conn, "message-id")
      headers = conn.req_headers

      {_, message_id_value} =
        Enum.find(headers, fn header_tuple -> elem(header_tuple, 0) == "message-id" end)

      assert message_id_value != ""
    end

    test "should return the header connection without modification" do
      header_without_message_id = TestStubs.header_with_message_id_value()
      conn = conn(:get, "/")
      conn = PlugHeaderTraceability.call(conn, "message-id")
      headers_map = DataTypeUtils.to_map(conn.req_headers)
      message_id_value = headers_map[:"message-id"]
      assert message_id_value != ""
    end

    test "should add message_id value in the header connection when message_id value come empty" do
      header_with_message_id_value_empty = TestStubs.header_with_message_id_value_empty()

      conn = conn(:get, "/")
      conn = %{conn | req_headers: header_with_message_id_value_empty}
      conn = PlugHeaderTraceability.call(conn, "message-id")
      headers = conn.req_headers

      {_, message_id_value} =
        Enum.find(headers, fn header_tuple -> elem(header_tuple, 0) == "message-id" end)

      assert message_id_value != ""
    end
  end
end
