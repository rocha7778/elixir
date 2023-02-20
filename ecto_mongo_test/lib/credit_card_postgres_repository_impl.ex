defmodule CreditCardInformation.Adapters.Repositories.CreditCardPostgresRepositoryImpl do
  @moduledoc """
  Implementation of Postgres repository: this module will execute all the sql queries to retrieve the data from the
  Postgres database.
  """

  # alias CreditCardInformation.Adapters.Repositories.CreditCardPostgresRepositoryImpl
  # CreditCardPostgresRepositoryImpl.get_customer_number("0000377813384145240")
  # CreditCardPostgresRepositoryImpl.get_customer_info_with_customer_number("0000377813384145240")
  # CreditCardPostgresRepositoryImpl.get_customer_info_without_customer_number("0000377813384145240")

  import Ecto.Query, only: [from: 2]
  require Logger
  alias CreditCardInformation.Ecto.Repo


  def get_customer_info_without_customer_number(credit_card_number) do
    Logger.debug(
      "Obteniendo datos del titular sin el numero de cliente | Numero de tarjeta de credito: #{credit_card_number}"
    )

    query =
      from(b in "bolsillos",
        where: b.numero_de_Cuenta == ^credit_card_number,
        select: {b.nombre_del_bolsillo, b.estado_del_bolsillo}
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
