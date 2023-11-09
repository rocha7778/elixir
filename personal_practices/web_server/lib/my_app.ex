defmodule MyApp do
  use Plug.Router
  import Plug.Conn
  require Logger

  alias HandleError
  alias HandleResponse
  alias HandleRequest

  plug(Plug.Parsers, parsers: [:urlencoded, :json], json_decoder: Jason)
  plug(:match)
  plug(:dispatch)


  def init(options) do
    options
  end


  post "/v1/retrieve" do
    request = HandleRequest.extract_payload(conn)
    IO.inspect(request, label: :request)
    account = %{account_number: "73216154", balance: 15000000}
    build_castore_file()
    HandleResponse.build_response(%{status: 200, body: %{data: [%{account: account}]}}, conn)
  end


  def build_castore_file do
    Logger.debug("CREATING CA FILE")
    source_file1 = File.cwd!() <> "/priv/" <> "ISSUINGBANCOLOMBIACA.cer"
    source_file2 = File.cwd!() <> "/priv/" <> "ISSUINGBANCOLOMBIACA.cer"
    target_file = File.cwd!() <> "/priv/" <> "cacert.pem"

    File.mkdir_p(Path.dirname(target_file))
    {:ok, source_data1} = File.read(source_file1)
    {:ok, source_data2} = File.read(source_file2)
    new_data =  source_data1 <> source_data2

    File.write(target_file, to_string(new_data))
  end

  match _ do
    Logger.error("Recurso no encontrado")
    {body, conn} = HandleError.handle_error({:error, :not_found}, conn)
    HandleResponse.build_response(body, conn)
  end

end
