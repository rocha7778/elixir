defmodule HandleRequest do

  use Plug.Router
  require Logger


  def init(options) do
    options
  end

  plug Request.Validator.Plug,
    register: App.Requests.Registration

  def register(_conn, params) do
    Logger.error("Register ")
    params
  end

  match _ do
    Logger.error("Recurso no encontrado")
  end
end
