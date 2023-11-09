defmodule PocketInformation.Adapters.Repositories.CategoryRepositoryImpl do
  @moduledoc """
  Implementation of category retrieval from cache pockets.
  """

  @behaviour PocketInformation.Domain.Gateways.CategoryRepository.Behaviour

  require Logger

  alias PocketInformation.Adapters.Cache.CacheImpl
  alias PocketInformation.Utils.DataTypeUtils
  alias PocketInformation.Config.AppConfig

  @collection AppConfig.get_db_category_collection()

  @doc """
    Obtains the category associated with the code of the consulted pocket
  """
  @impl true
  def get_category(category) do
    with {:ok, category_i} <- DataTypeUtils.string_to_integer(category.id) do
      case CacheImpl.get_reference(category_i) do
        {:error, :reference_not_cached} ->
          Logger.debug("No se encontro la referencia para la categoria #{category_i} en cache")

          case find_references() do
            [] ->
              Logger.debug("No se encontraron las referencias en MongoDB")
              {:error, "No se encontraron las referencias"}

            references ->
              case Enum.find(references, fn {k, _} -> k == category_i end) do
                nil ->
                  Logger.debug("No se encontro la referencia en MongoDB")
                  {:error, "No se encontro la referencia"}

                {_, v} ->
                  CacheImpl.insert(references)
                  {:ok, %{category | reference: v}}
              end
          end

        {:ok, reference} ->
          {:ok, %{category | reference: reference}}
      end
    end
  end

  def find_references do

    {micro_seconds, response_database} = :timer.tc(Mongo, :find, [:mongodb, @collection, %{}])
          Logger.debug(
              "Tiempo de respuesta de la base de datos mongodb consulta get_category: #{inspect(micro_seconds/1_000_000)} sg"
            )

    response_database
    |> Enum.map(fn %{"Referencia_imagen_categoria" => v, "Codigo_de_categoria" => k} ->
      {k, v}
    end)
  end
end
