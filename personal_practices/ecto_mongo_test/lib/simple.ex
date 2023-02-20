defmodule Simple do
  import Ecto.Query
  require Logger

  def sample_query do
    query = from w in Weather,
          where: w.prcp > 0 or is_nil(w.prcp),
         select: w
    Repo.all(query)
  end

  def get_customer_info_without_customer_number(credit_card_number) do
    Logger.debug(
      "Obteniendo datos del titular sin el numero de cliente | Numero de tarjeta de credito: #{credit_card_number}"
    )

    query =
      from(c in "bolsillo",
        select: {c.nombre_del_bolsillo, c.numero_de_Cuenta}
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
