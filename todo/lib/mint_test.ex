defmodule MintTest do
  def test do
    {:ok, conn} = Mint.HTTP.connect(:http, "localhost", 3000)
    {:ok, conn, request_ref} = Mint.HTTP.request(conn, "GET", "/users", [], nil)
     message = handle_response(conn, request_ref)
     calculate_salary(message)
  end

  def test2 do
    {:ok, conn} = Mint.HTTP.connect(:http, "localhost", 3000)
    {:ok, conn, request_ref} = Mint.HTTP.request(conn, "POST", "/xml", [], nil)
     message = handle_response(conn, request_ref)

     IO.inspect(message)
     #calculate_salary(message)
  end

  defp calculate_salary(message) do
    salary = with {:ok, jsons} <-message,
         {:ok, data} <- Jason.decode(jsons),
         {:ok, empl} <- Map.fetch(data, "users") do
          empl |> Enum.map(fn k -> k["salary"] end) |> Enum.sum()
    end
    {:ok, salary}


  end

  def get do
    Application.get_env(:todo, :http)
  end

  def handle_response(conn, request_ref, body \\ []) do
      receive do
        message ->
          case Mint.HTTP.stream(conn, message) do

            {:ok, conn, responses} ->
              IO.inspect(responses)
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
  end

  
end
