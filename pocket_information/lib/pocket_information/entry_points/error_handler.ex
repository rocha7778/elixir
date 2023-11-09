defmodule PocketInformation.EntryPoints.ErrorHandler do
  @moduledoc """
  This module is in charge of build and return the error response of the API.
  An example of an error response that gets generated with this module is the follow:
  
  {
    "title": "Internal server error",
    "status": 500,
    "meta": {
        "_requestDateTime": "2022-07-15T17:53:29.376000Z",
        "_messageId": "343434343434",
        "_applicationId": "12312321"
    },
    "errors": [
        {
            "detail": "Error interno del servidor",
            "code": "500"
        }
    ]
  }
  """

  defstruct [
    :meta,
    :status,
    :title,
    :errors
  ]

  def build_error_response({{:error, :error_on_request}, message_id, application_id}),
    do:
      make_error(
        400,
        "Error on request",
        "400",
        "Error en la solicitud",
        message_id,
        application_id
      )

  def build_error_response({{:error, :pocket_not_found}, message_id, application_id}),
    do:
      make_error(
        409,
        "Pocket not found",
        "409",
        "Bolsillo no existe",
        message_id,
        application_id
      )

  def build_error_response({{:error, :account_not_found}, message_id, application_id}),
    do:
      make_error(
        409,
        "Account not found",
        "409",
        "Cuenta no existe",
        message_id,
        application_id
      )

  def build_error_response({{:error, :not_found}, message_id, application_id}),
    do:
      make_error(
        404,
        "Resource not found",
        "404",
        "Recurso no encontrado",
        message_id,
        application_id
      )

  def build_error_response({{:error, :unauthorized}, message_id, application_id}),
    do:
      make_error(
        401,
        "Incorrect credentials",
        "401",
        "Credenciales incorrectas",
        message_id,
        application_id
      )

  def build_error_response({{:error, :internal_server_error}, message_id, application_id}),
    do:
      make_error(
        500,
        "Internal server error",
        "500",
        "Error interno del servidor",
        message_id,
        application_id
      )

  def build_error_response({_, message_id, application_id}),
    do:
      make_error(
        500,
        "Internal server error",
        "500",
        "Error interno del servidor",
        message_id,
        application_id
      )

  def make_error(status, title, code, detail, message_id, application_id) do
    %{
      meta: %{
        "_messageId" => message_id,
        "_requestDateTime" => Timex.now(),
        "_applicationId" => application_id
      },
      status: status,
      title: title,
      errors: [
        %{
          "code" => code,
          "detail" => detail
        }
      ]
    }
  end
end
