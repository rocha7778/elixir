defmodule StringHelper do
  @doc """
  String Helper

  ## Examples

      iex> StringHelper.find_longest_string(["aaa", "aa", "a"])
      "aaa"
  """
  @spec find_longest_string([String.t()]) :: String.t() | nil
  def find_longest_string([]), do: nil

  def find_longest_string([str | rest]) do
    find_longest_string(rest, str)
  end

  defp find_longest_string([], longest), do: longest

  defp find_longest_string([str | rest], longest) do
    new_longest =
      if String.length(str) > String.length(longest) do
        str
      else
        longest
      end

    find_longest_string(rest, new_longest)
  end
end
