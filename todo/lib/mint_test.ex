defmodule MintTest do
  def test do
    {:ok, conn} = Mint.HTTP.connect(:http, "localhost", 3000)
    {:ok, conn, request_ref} = Mint.HTTP.request(conn, "GET", "/users", [], nil)

    total_sueldo =
      with {:ok, jsons} <- handle_response(conn, request_ref),
           {:ok, data} <- Jason.decode(jsons),
           {:ok, empl} <- Map.fetch(data, "users") do
        empl |> Enum.map(fn k -> k["sueldo"] end) |> Enum.sum()
      end
  end

  defp handle_response(conn, request_ref, body \\ []) do
    {conn, http_status, body, status} =
      receive do
        message ->
          case Mint.HTTP.stream(conn, message) do
            {:ok, conn, responses} ->
              {body, status} =
                Enum.reduce(
                  responses,
                  {body, :incomplete},
                  fn res, {body, _status} ->
                    case res do
                      {:status, ^request_ref, _status_code} -> {body, :incomplete}
                      {:headers, ^request_ref, _headers} -> {body, :incomplete}
                      {:data, ^request_ref, data} -> {[data | body], :incomplete}
                      {:done, ^request_ref} -> {Enum.reverse(body), :complete}
                      :unknown -> {body, :incomplete}
                    end
                  end
                )

              {conn, :ok, body, status}

            {:error, conn, reason, _responses} ->
              {conn, reason, [], :complete}
          end
      end

    if status == :complete do
      IO.puts("competed xxx")
      Mint.HTTP.close(conn)
      {http_status, body}
    else
      IO.puts("not competed")
      handle_response(conn, request_ref, body)
    end
  end
end
