defmodule PocketInformation.Utils.HTTP.NullFieldRemover do
  def remove_fields(body) do
    body_map = List.first(body.data)

    account = ensure_map(body_map.account)
    pocket = remove_null_pocket_values(body_map.account.pocket)
    dates = remove_null_date_values(body_map.account.pocket.dates)
    scheduledTransfer = remove_null_scheduler_values(body_map.account.pocket.scheduledTransfer)

    pocket = %{pocket | scheduledTransfer: scheduledTransfer}
    pocket = %{pocket | dates: dates}

    updated_message = %{account | pocket: pocket}
    %{data: [%{account: updated_message}]}
  end

  def ensure_map(%{__struct__: _} = struct), do: Map.from_struct(struct)
  def ensure_map(data), do: data

  defp remove_null_pocket_values(pocket) do
    pocket = ensure_map(pocket)
    keys = [:closedDate, :savingsGoal]
    delete_keys_with_null_value(keys, pocket)
  end

  defp remove_null_date_values(%{savingsEndDate: nil} = pocket) do
    remove_null_field(pocket, :savingsEndDate)
  end

  defp remove_null_date_values(pocket) do
    pocket
  end

  defp remove_null_field(map, key) do
    pocket = ensure_map(map)
    Map.delete(pocket, key)
  end

  defp remove_null_scheduler_values(pocket) do
    pocket = ensure_map(pocket)
    keys = [:frequency, :startDate, :endDate]
    delete_keys_with_null_value(keys, pocket)
  end

  defp delete_keys_with_null_value(keys, pocket) do
    Map.drop(pocket, Enum.filter(keys, fn key -> (pocket[key] == nil) end))
  end
end
