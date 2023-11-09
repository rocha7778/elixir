defmodule PocketInformation.Domain.Validations do
  def validate_type(value, :atom) when is_atom(value) and value != nil, do: {:ok, value}
  def validate_type(value, :float) when is_float(value), do: {:ok, value}
  def validate_type(value, :integer) when is_integer(value), do: {:ok, value}
  def validate_type(value, :string) when is_binary(value), do: {:ok, value}
  def validate_type(value, :boolean) when is_boolean(value), do: {:ok, value}
  def validate_type(value = %Decimal{}, :decimal), do: {:ok, value}
  def validate_type(value, type), do: {:error, "#{inspect(value)} is not a #{type}"}
end
