defmodule PocketInformation.Domain.Model.Account.AccountConditions do
  import PocketInformation.Domain.Validations

  defstruct [
    :inactive_days,
    :allow_debit,
    :allow_credit,
    :is_closed
  ]

  def new(map) do
    with {:ok, is_closed_v} <- validate_type(map["is_closed"], :boolean) do
      {:ok,
       %__MODULE__{
         inactive_days: map["inactive_days"],
         allow_debit: map["allow_debit"],
         allow_credit: map["allow_credit"],
         is_closed: is_closed_v
       }}
    end
  end
end
