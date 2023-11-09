defmodule PocketInformation.Domain.Model.Pocket.SavingDates do
  @type t :: %__MODULE__{savingsStartDate: String.t(), savingsEndDate: String.t()}

  @derive Jason.Encoder
  defstruct [
    :savingsStartDate,
    :savingsEndDate
  ]

  def new(savings_start_date, savings_end_date) do
    %__MODULE__{
      savingsStartDate: savings_start_date,
      savingsEndDate: savings_end_date
    }
  end
end
