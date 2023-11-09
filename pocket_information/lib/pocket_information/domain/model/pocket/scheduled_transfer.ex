defmodule PocketInformation.Domain.Model.Pocket.ScheduledTransfer do
  @type t :: %__MODULE__{
          frequency: String.t(),
          day: integer,
          startDate: String.t(),
          endDate: String.t(),
          amount: integer
        }

  @frequency_values ["DIARIA", "SEMANAL", "QUINCENAL", "MENSUAL"]

  @derive Jason.Encoder
  defstruct [
    :frequency,
    :day,
    :startDate,
    :endDate,
    :amount
  ]

  def new(frequency, day, start_date, end_date, amount) do
    with {:ok, frequency} <- validate_frequency(frequency) do
      {:ok,
       %__MODULE__{
         frequency: frequency,
         day: day,
         startDate: start_date,
         endDate: end_date,
         amount: amount
       }}
    end
  end

  defp validate_frequency(""), do: {:ok, nil}
  defp validate_frequency(nil), do: {:ok, nil}

  defp validate_frequency(frequency) do
    if Enum.member?(@frequency_values, frequency) do
      {:ok, frequency}
    else
      {:error, :no_valid_frequency}
    end
  end
end
