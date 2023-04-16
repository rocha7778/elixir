defmodule MyApp do
  use Plug.Router
  require Logger

  plug(Plug.Parsers, parsers: [:urlencoded, :json], json_decoder: Jason)
  plug(:match)
  plug(:dispatch)

  def init(options) do
    options
  end

  post "/v1/retrieve" do
    IO.puts("Response")
    request = DataTypeUtils.normalize(conn.body_params)
    HandleRequest.register(conn,request)
    HandleResponse.build_response(%{status: 200, body: %{data: request}}, conn)
  end


  match _ do
    Logger.error("Recurso no encontrado")
    {body, conn} = HandleError.handle_error({:error, :not_found}, conn)
    HandleResponse.build_response(body, conn)
  end



end
