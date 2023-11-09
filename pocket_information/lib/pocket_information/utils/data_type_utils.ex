defmodule PocketInformation.Utils.DataTypeUtils do
  @moduledoc """
  This module contains functions to parse and normalize data structures.
  """
  require Logger

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
    |> Enum.map(fn {key, value} -> {string_to_atom(key), normalize(value)} end)
    |> Enum.into(%{})
  end

  def normalize(value) when is_list(value), do: Enum.map(value, &normalize/1)
  def normalize(value), do: value

  def string_to_atom(value) when is_atom(value), do: value
  def string_to_atom(value), do: String.to_atom(value)

  def parse_http_header(headers, header_name) do
    headers
    |> to_map()
    |> Map.fetch!(String.to_atom(header_name))
  end

  def string_to_integer(str) do
    try do
      {:ok, String.to_integer(str)}
    rescue
      _ ->
        Logger.error("error trying to parse #{str} to string")
        {:error, :internal_server_error}
    end
  end

  def integer_to_string(number) do
    try do
      {:ok, Integer.to_string(number)}
    rescue
      _ ->
        Logger.error("error trying to parse #{number} to integer")
        {:error, :internal_server_error}
    end
  end

  def integer_to_float(nil), do: {:ok, nil}

  def integer_to_float(number) do
    try do
      {:ok, number / 1}
    rescue
      _ ->
        Logger.error("error trying to parse #{number} to float}")
        {:error, :internal_server_error}
    end
  end

  def validate_nil_number(number) do
    if number == nil, do: {:ok, nil}, else: {:ok, Decimal.from_float(number)}
  end

  def integer_to_date(0), do: {:ok, nil}
  def integer_to_date(nil), do: {:ok, nil}

  def integer_to_date(number) do
    with {:ok, <<yyyy::binary-4, mm::binary-2, dd::binary-2>>} <- integer_to_string(number) do
      {:ok, "#{yyyy}-#{mm}-#{dd}"}
    else
      _ ->
        Logger.error("error trying to parse #{number} to date")
        {:error, :internal_server_error}
    end
  end
end
