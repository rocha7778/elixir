defmodule Example.Router do
  use Plug.Router
  import Plug.Conn

  require Exonerate




  plug(Plug.Logger)
  plug(:match)
  plug(:dispatch)
  plug(Plug.Parsers, parsers: [:json], json_decoder: Poison)




  get("/hello", do: send_resp(conn, 200, "Hello world"))


  post "/test/hola" do

    result = (conn.body_params)

    IO.inspect(result)

    conn
    |> put_resp_content_type("application/vnd.bancolombia.v4+json")
    |> send_resp(200,Poison.encode!(%{hola: :mundo}))

  end

  match(_, do: send_resp(conn, 404, "Oops!"))
end
