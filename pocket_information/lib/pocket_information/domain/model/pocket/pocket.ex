defmodule PocketInformation.Domain.Model.Pocket.Pocket do
  @moduledoc """
  This defines the Pocket Information Entity, with it's properties.
  """

  import PocketInformation.Domain.Validations

  alias PocketInformation.Domain.Model.Pocket.SavingDates
  alias PocketInformation.Domain.Model.Pocket.Category
  alias PocketInformation.Domain.Model.Pocket.ScheduledTransfer

  @pocket_states ["ACTIVO", "CANCELADO"]

  @enforce_keys :number
  @derive Jason.Encoder
  defstruct [
    :number,
    :name,
    :dates,
    :state,
    :savingsGoal,
    :balance,
    :openDate,
    :closedDate,
    :category,
    :scheduledTransfer
  ]

  @type t :: %__MODULE__{
          number: String.t(),
          name: String.t(),
          dates: SavingDates.t(),
          state: String.t(),
          savingsGoal: String.t(),
          balance: String.t(),
          openDate: String.t(),
          closedDate: String.t(),
          category: Category.t(),
          scheduledTransfer: ScheduledTransfer.t()
        }

  def new(number) do
    {:ok, %__MODULE__{number: number}}
  end

  def new(
        number,
        name,
        savings_start_date,
        savings_end_date,
        state,
        savings_goal,
        balance,
        open_date,
        closed_date,
        id_category,
        id_category_reference,
        st_frecuency,
        st_day,
        st_start_date,
        st_end_date,
        st_amount
      ) do
    with {:ok, number_v} <- validate_type(number, :string),
         {:ok, name_v} <- validate_type(name, :string),
         {:ok, balance_v} <- validate_type(balance, :decimal),
         {:ok, open_date_v} <- validate_type(open_date, :string),
         {:ok, state_v} <- validate_state(state),
         {:ok, category_v} <-
           Category.new(
             id_category,
             id_category_reference
           ),
         {:ok, scheduled_transfer} <-
           ScheduledTransfer.new(
             st_frecuency,
             st_day,
             st_start_date,
             st_end_date,
             st_amount
           ) do
      {:ok,
       %__MODULE__{
         number: number_v,
         name: name_v,
         dates:
           SavingDates.new(
             savings_start_date,
             savings_end_date
           ),
         state: state_v,
         savingsGoal: savings_goal,
         balance: balance_v,
         openDate: open_date_v,
         closedDate: closed_date,
         category: category_v,
         scheduledTransfer: scheduled_transfer
       }}
    end
  end

  def update_category(category, pocket) do
    %{pocket | category: category}
  end

  defp validate_state(state) do
    if Enum.member?(@pocket_states, state) do
      {:ok, state}
    else
      {:error, :no_valid_state}
    end
  end
end
