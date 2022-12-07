defmodule CreditCardInformation.Adapters.Repositories.CreditCardPostgresRepositoryImpl do
  @moduledoc """
  Implementation of Postgres repository: this module will execute all the sql queries to retrieve the data from the
  Postgres database.
  """

  # CreditCardPostgresRepositoryImpl.get_customer_number("0000377813384145240")
  # CreditCardPostgresRepositoryImpl.get_customer_info_with_customer_number("0000377813384145240")
  # CreditCardPostgresRepositoryImpl.get_customer_info_without_customer_number("0000377813384145240")

  import Ecto.Query, only: [from: 2]
  require Logger
  alias CreditCardInformation.Ecto.Repo



  @doc """
  Gets the customer number from the table amed_customer_nbr using the customer credit card number.
  """
  def get_customer_number(credit_card_number) do
    Logger.debug(
      "Obteniendo el numero de cliente | Numero de tarjeta de credito: #{credit_card_number}"
    )

    query =
      from(c in "embosser",
        where: c.amed_org == "807" and c.amed_card_nbr == ^credit_card_number,
        select: c.amed_customer_nbr
      )

    try do
      query_result = Repo.all(query)

      case length(query_result) do
        0 ->
          Logger.debug(
            "No se encontro ninguna tarjeta de credito con el numero: #{credit_card_number}"
          )

          {:no_result}

        1 ->
          case query_result do
            [nil] ->
              Logger.debug(
                "No se encontro el numero de cliente para la tarjeta de credito: #{credit_card_number}"
              )

              {:no_result}

            [customer_number] ->
              {:ok, customer_number}
          end

        _ ->
          Logger.error(
            "Error, se encontro mas de un resultado para la tarjeta de credito: #{credit_card_number}"
          )

          {:error, :internal_server_error}
      end
    rescue
      e ->
        Logger.error("Ocurrio un error al intentar realizar la consulta sql:")
        Logger.error(e)
        {:error, :service_unavailable}
    end
  end

  @doc """
  Gets the client document number and document type using the customer number, from the table customer.
  """
  def get_customer_info_with_customer_number(customer_number) do
    Logger.debug(
      "Obteniendo datos del titular con el numero de cliente | Numero de cliente: #{customer_number}"
    )

    query =
      from(c in "customer",
        where: c.amna_org == "807" and c.amna_acct == ^customer_number,
        select: {c.amna_user_4_1, c.amna_ssan_1}
      )

    try do
      Repo.all(query)
    rescue
      e ->
        Logger.error("Ocurrio un error al intentar realizar la consulta sql:")
        Logger.error(e)
        {:error, :service_unavailable}
    end
  end

  @doc """
  Gets the client document number and document type using the credit card number, from the table emision_tarjeta_credito.
  """
  def get_customer_info_without_customer_number(credit_card_number) do
    Logger.debug(
      "Obteniendo datos del titular sin el numero de cliente | Numero de tarjeta de credito: #{credit_card_number}"
    )

    query =
      from(c in "emision_tarjeta_credito",
        where: c.numero_tarjeta == ^credit_card_number,
        select: {c.tipo_identificacion, c.numero_identificacion}
      )

    try do
      Repo.all(query)
    rescue
      e ->
        Logger.error("Ocurrio un error al intentar realizar la consulta sql:")
        Logger.error(e)
        {:error, :service_unavailable}
    end
  end
end
