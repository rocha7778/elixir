defmodule Util do
  @moduledoc """
  This module contains functions to parse and normalize data structures.
  """

  def to_map(list) when is_list(list) and length(list) > 0 do
    case list |> List.first() do
      {_, _} ->
        Enum.reduce(list, %{}, fn tuple, acc ->
          {key, value} = tuple
          Map.put(acc, String.to_atom(key), to_map(value))
        end)

      _ ->
        list
    end
  end

  def to_map(value), do: value

  def normalize(%{} = map) do
    Map.to_list(map)
    |> Enum.map(fn {key, value} -> {String.to_atom(key), normalize(value)} end)
    |> Enum.into(%{})
  end

  def normalize(value) when is_list(value), do: Enum.map(value, &normalize/1)
  def normalize(value), do: value

  def parse_http_header(headers, header_name) do
    headers
    |> to_map()
    |> Map.fetch!(String.to_atom(header_name))
  end
end
