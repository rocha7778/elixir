defmodule PocketInformation.EntryPoints.Http.Rest.ApiRestController do
  @moduledoc """
  Controller that has the HTTP rest operations to get the pocket information
  """

  use Plug.Router

  import Plug.Conn

  require Logger

  alias PocketInformation.Domain.UseCases.Pocket.GetPocketUseCase
  alias PocketInformation.EntryPoints.Http.Rest.ApiRestControllerHelper
  alias PocketInformation.EntryPoints.ErrorHandler
  alias PocketInformation.Utils.DataTypeUtils
  alias PocketInformation.Utils.HTTP.PlugTrxLogger
  alias PocketInformation.Utils.HTTP.PlugHeaderTraceability

  @message_id :"message-id"
  @ibm_client_id_api_account_information :"x-ibm-client-id"

  plug(:auth)
  plug(PlugHeaderTraceability, "message-id")
  plug(Plug.RequestId, http_header: "message-id")
  plug(Plug.Logger)
  plug(:match)
  plug(Plug.Parsers, parsers: [:urlencoded, :json], json_decoder: Jason)
  #plug(PlugTrxLogger)
  plug(:dispatch)

  def init(options) do
    options
  end

  post "/v1/operations/product-specific/deposits/accounts/pockets/retrieve" do
    with {:ok, request, traceability} <-
           ApiRestControllerHelper.validate_retrieve_pocket_payload(conn),
         {:ok, account} <- GetPocketUseCase.handle_use_case(request, traceability) do
      build_response(%{status: 200, body: %{data: [%{account: account}]}}, conn)
    else
      error ->
        handle_error(error, conn)
    end
  end

  match _ do
    Logger.error("Recurso no encontrado")
    handle_error({:error, :not_found}, conn)
  end

  defp build_response(%{status: status, body: body}, conn) do
    conn
    |> put_resp_content_type("application/vnd.bancolombia.v4+json")
    |> send_resp(status, Jason.encode!(body))
  end

  def handle_error(error, conn) do
    {message_id, client_id} = get_headers(conn)
    error_body = ErrorHandler.build_error_response({error, message_id, client_id})
    {_, error_code} = error

    cond do
      error_code == :error_on_request ->
        build_response(%{status: 400, body: error_body}, conn)

      error_code == :pocket_not_found ->
        build_response(%{status: 409, body: error_body}, conn)

      error_code == :account_not_found ->
        build_response(%{status: 409, body: error_body}, conn)

      error_code == :not_found ->
        build_response(%{status: 404, body: error_body}, conn)

      error_code == :unauthorized ->
        build_response(%{status: 401, body: error_body}, conn)

      error_code == :internal_server_error ->
        build_response(%{status: 500, body: error_body}, conn)

      true ->
        build_response(%{status: 500, body: error_body}, conn)
    end
  end

  defp get_headers(conn) do
    headers = DataTypeUtils.to_map(conn.req_headers)

    message_id =
      if headers[@message_id] != nil and headers[@message_id] != "",
        do: headers[@message_id],
        else: ""

    client_id_api_account_information =
      if headers[@ibm_client_id_api_account_information] != nil and
           headers[@ibm_client_id_api_account_information] != "",
         do: headers[@ibm_client_id_api_account_information],
         else: ""

    {message_id, client_id_api_account_information}
  end

  defp auth(conn, _opts) do
    with {user, pass} <- Plug.BasicAuth.parse_basic_auth(conn),
         {:ok, login_user} <- ApiRestControllerHelper.validate_user_and_password(user, pass) do
      assign(conn, :current_user, login_user)
    else
      _ ->
        Logger.error("Error de autenticacion, las credenciales no son correctas")
        handle_error({:error, :unauthorized}, conn) |> halt()
    end
  end
end
