defmodule PocketInformation.Adapters.Cache.CacheImpl do
  @moduledoc """
  This module defines the operations available for the ETS
  """
  @cache_name :bvdffblcat

  def start do
    :ets.new(@cache_name, [:public, :named_table, :bag])
  end

  def insert(references) do
    :ets.insert_new(@cache_name, references)
  end

  def get_reference(code) do
    fun = [{{:"$1", :"$2"}, [{:==, :"$1", code}], [:"$2"]}]

    case to_string(:ets.select(@cache_name, fun)) do
      "" -> {:error, :reference_not_cached}
      result -> {:ok, result}
    end
  end
end
