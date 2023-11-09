defmodule PocketInformation.Utils.HTTP.PlugHeaderTraceability do
  @moduledoc false

  @behaviour Plug
  require Logger

  @impl true
  def init(header_name) do
    header_name
  end

  @impl true
  def call(conn, header_name) do
    headers = conn.req_headers

    case get_message_id(headers, header_name) do
      {:ok, _} ->
        conn

      {:message_id_empty, _} ->
        Logger.debug("Agregando message-id a el header de conexion")
        headers = delete_message_id_tuple(headers)
        add_headers_conn(conn, headers, header_name)

      _ ->
        Logger.debug("Agregando message-id a el header de conexion")
        add_headers_conn(conn, headers, header_name)
    end
  end

  defp add_headers_conn(conn, headers, header_name) do
    %{conn | req_headers: [{header_name, UUID.uuid1()} | headers]}
  end

  defp delete_message_id_tuple(headers) do
    Enum.reject(headers, fn header_tuple -> elem(header_tuple, 0) == "message-id" end)
  end

  defp get_message_id(headers, header_name) do
    case Enum.find(headers, fn header_tuple -> elem(header_tuple, 0) == header_name end) do
      nil -> {:error, :not_found}
      {_, ""} -> {:message_id_empty, :value_empty}
      {_, message_id_value} -> {:ok, message_id_value}
    end
  end
end
