defmodule PocketInformation.Adapters.Repositories.PocketRepositoryImpl do
  @moduledoc """
  Specialization of a interface for a specific context.
  """

  require Logger

  @behaviour PocketInformation.Domain.Gateways.PocketRepository.Behaviour

  alias PocketInformation.Domain.Model.Pocket.Pocket
  alias PocketInformation.Domain.Model.Account.Account
  alias PocketInformation.Utils.DataTypeUtils
  alias PocketInformation.Config.AppConfig

  @collection AppConfig.get_db_pocket_collection()

  @impl true
  def get_pocket(account) do
    with {:ok, pocket} <- get_pocket_from_bd(account),
         normalized_pocket <- normalize_pocket_from_db(pocket),
         {:ok, pocket_entity} <- build_pocket_entity(normalized_pocket) do
      {:ok, pocket_entity}
    else
      {error, reason} ->
        {error, reason}

      error ->
        Logger.error("ocurrio un error no manejado al consultar el bolsillo: #{inspect(error)}}")
        {:error, :internal_server_error}
    end
  end

  defp get_pocket_from_bd(account) do
    with {:ok, pocked_id_str} <- extract_pocket_id(account),
         {:ok, pocked_id} <- DataTypeUtils.string_to_integer(pocked_id_str),
         {:ok, account_number} <- DataTypeUtils.string_to_integer(account.number) do
      query_pocket = %{Numero_de_Cuenta: account_number, Codigo_del_bolsillo: pocked_id}

      {micro_seconds, response_database} = :timer.tc(Mongo, :find, [:mongodb, @collection, query_pocket])
      Logger.debug(
        "Tiempo de respuesta de la base de datos mongodb consulta get_pocket: #{inspect(micro_seconds/1_000_000)} sg"
      )

      response_database
      |> Enum.to_list()
      |> List.first()
      |> case do
        nil ->
          Logger.error("No se encontro informacion del bolsillo")
          {:error, :pocket_not_found}

        pocket ->
          {:ok, pocket}
      end
    end
  end

  defp extract_pocket_id(%Account{
         number: account_number,
         pocket: %Pocket{number: pocket_number}
       }) do
    case String.split(pocket_number, account_number) do
      ["", ""] ->
        Logger.error("No se pudo extraer el id del bolsillo desde el numero de bolsillo")
        {:error, :internal_server_error}

      ["", pocket_id] ->
        {:ok, pocket_id}

      err ->
        Logger.error(
          "No se pudo extraer el id del bolsillo desde el numero de bolsillo: #{inspect(err)}"
        )

        {:error, :internal_server_error}
    end
  end

  defp normalize_pocket_from_db(pocket) do
    DataTypeUtils.normalize(pocket)
  end

  defp build_pocket_entity(pocket_map) do
    with {:ok, homologated_pocket_state} <-
           homologate_pocket_state(Map.get(pocket_map, :Estado_del_bolsillo)),
         {:ok, homologated_frequency} <-
           homologate_frequency(Map.get(pocket_map, :Periodicidad_ahorro, "")),
         {:ok, pocket_id} <-
           build_pocket_number(
             Map.get(pocket_map, :Numero_de_Cuenta),
             Map.get(pocket_map, :Codigo_del_bolsillo)
           ),
         {:ok, fecha_inicio_ahorro} <-
           DataTypeUtils.integer_to_date(Map.get(pocket_map, :Fecha_de_creacion)),
         {:ok, fecha_fin_ahorro} <-
           DataTypeUtils.integer_to_date(Map.get(pocket_map, :Fecha_fin_ahorro)),
         {:ok, fecha_de_creacion} <-
           DataTypeUtils.integer_to_date(Map.get(pocket_map, :Fecha_de_creacion)),
         {:ok, fecha_cancelacion} <-
           DataTypeUtils.integer_to_date(Map.get(pocket_map, :Fecha_Cancelacion)),
         {:ok, fecha_inicio_trans_programada} <-
           DataTypeUtils.integer_to_date(Map.get(pocket_map, :Fecha_inicio_trans_programada)),
         {:ok, fecha_fin_trans_programada} <-
           DataTypeUtils.integer_to_date(Map.get(pocket_map, :Fecha_fin_trans_programada)),
         {:ok, valor_total_de_la_Meta} <-
           DataTypeUtils.integer_to_float(Map.get(pocket_map, :Valor_total_de_la_Meta)),
         {:ok, valor_total_de_la_Meta} <-
          DataTypeUtils.validate_nil_number(valor_total_de_la_Meta),
         {:ok, saldo_del_bolsillo} <-
           DataTypeUtils.integer_to_float(Map.get(pocket_map, :Saldo_del_bolsillo)),
         {:ok, valor_trans_programada} <-
           DataTypeUtils.integer_to_float(Map.get(pocket_map, :Valor_trans__programada)),
         {:ok, id_category} <-
           DataTypeUtils.integer_to_string(Map.get(pocket_map, :Codigo_de_categoria)),
         {:ok, pocket} <-
           Pocket.new(
             pocket_id,
             Map.get(pocket_map, :Nombre_del_bolsillo),
             fecha_inicio_ahorro,
             fecha_fin_ahorro,
             homologated_pocket_state,
             valor_total_de_la_Meta,
             Decimal.from_float(saldo_del_bolsillo),
             fecha_de_creacion,
             fecha_cancelacion,
             String.pad_leading(id_category, 4, "0"),
             nil,
             homologated_frequency,
             Map.get(pocket_map, :Dia_trans__programada),
             fecha_inicio_trans_programada,
             fecha_fin_trans_programada,
             Decimal.from_float(valor_trans_programada)
           ) do
      {:ok, pocket}
    else
      {error, reason} ->
        Logger.error("error al crear entidad pocket: #{reason}")
        {error, reason}

      error ->
        Logger.error("error no controlado al crear la entidad pocket : #{error}")
        {:error, error}
    end
  end

  defp build_pocket_number(account_number, pocked_id) do
    with {:ok, account_number_str} <- DataTypeUtils.integer_to_string(account_number),
         {:ok, pocket_id_str} <- DataTypeUtils.integer_to_string(pocked_id) do
      {:ok, account_number_str <> pocket_id_str}
    else
      {error, reason} ->
        Logger.error("error al construir el id del bolsillo: #{reason}")
        {error, reason}
    end
  end

  defp homologate_pocket_state(state) do
    case String.trim(state) do
      "A" ->
        {:ok, "ACTIVO"}

      "C" ->
        {:ok, "CANCELADO"}

      _ ->
        Logger.error("error al homologar el estado: #{inspect(state)}")
        {:error, :internal_server_error}
    end
  end

  defp homologate_frequency(frequency) do
    case String.trim(frequency) do
      "D" ->
        {:ok, "DIARIA"}

      "S" ->
        {:ok, "SEMANAL"}

      "Q" ->
        {:ok, "QUINCENAL"}

      "M" ->
        {:ok, "MENSUAL"}

      _ ->
        {:ok, nil}
    end
  end
end
