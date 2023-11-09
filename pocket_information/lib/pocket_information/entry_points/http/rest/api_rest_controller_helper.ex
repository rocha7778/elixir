defmodule PocketInformation.EntryPoints.Http.Rest.ApiRestControllerHelper do
  @moduledoc """
  This module provides methods to validate the incoming requests and builds the domain object
  """
  require Logger
  require Exonerate

  alias PocketInformation.Utils.DataTypeUtils
  alias PocketInformation.Domain.Model.Account.Account
  alias PocketInformation.Utils.SchemaValidation
  alias PocketInformation.Config.AppConfig

  @savings_account_type "CUENTA_DE_AHORRO"
  @message_id :"message-id"

  @doc """
  Getting the data from conn object
  """
  def validate_retrieve_pocket_payload(conn) do
    Logger.debug("obteniendo los datos peticion consulta de bolsillo")

    with :ok <- SchemaValidation.validate_retrieve_pocket_payload(conn.body_params),
         {:ok, account_payload} <- extract_account_payload(conn),
         {:ok, _} <- validate_pocket_number(account_payload),
         {:ok, _} <- validate_saving_account_type(account_payload),
         {:ok, account} <- build_account_entity(account_payload) do
      headers_map = DataTypeUtils.to_map(conn.req_headers)
      {:ok, account, %{message_id: headers_map[@message_id]}}
    else
      {:error, _} ->
        {:error, :error_on_request}

      error ->
        Logger.error(
          "Ocurrio un error no controlado al validar la solicitud | Error: #{inspect(error)}"
        )

        {:error, :error_on_request}
    end
  end

  defp validate_pocket_number(%{
         number: account_number,
         pocket: %{number: pocket_number}
       }) do
    case String.split(pocket_number, account_number) do
      ["", ""] ->
        Logger.error("No se pudo extraer el id del bolsillo desde el numero de bolsillo")
        {:error, "Error al extraer el id del bolsillo"}

      ["", pocket_id_str] ->
        {:ok, pocket_id_str}

      err ->
        Logger.error(
          "No se pudo extraer el id del bolsillo desde el numero de bolsillo: #{inspect(err)}"
        )

        {:error, "Error al extraer el id del bolsillo"}
    end
  end

  defp extract_account_payload(conn) do
    request = DataTypeUtils.normalize(conn.body_params)
    {:ok, List.first(request.data).account}
  end

  defp build_account_entity(account) do
    Account.new(account.type, account.number, account.pocket.number)
  end

  defp validate_saving_account_type(%{type: account_type}) do
    if account_type == @savings_account_type do
      {:ok, account_type}
    else
      Logger.error("No es un tipo de cuenta valido para la operacion")
      {:error, "Error en el tipo de cuenta"}
    end
  end

  @doc """
  It validates the credentials of the basic authentication of the request API against the credentials
  that are stored in a Secret on Openshift.
  """
  def validate_user_and_password(user, password) do
    Logger.debug("Validando las credenciales de la autenticacion basica")

    if Plug.Crypto.secure_compare(AppConfig.basic_auth_username(), user) and
         Plug.Crypto.secure_compare(AppConfig.basic_auth_password(), password) do
      {:ok, %{"user" => user, "pass" => password}}
    else
      {:error, "unauthorized"}
    end
  end
end
