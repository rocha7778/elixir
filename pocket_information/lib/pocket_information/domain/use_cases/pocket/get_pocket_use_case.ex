defmodule PocketInformation.Domain.UseCases.Pocket.GetPocketUseCase do
  @moduledoc """
  Belonging to the domain layer, it implements the use cases of the system,
  defines application logic and reacts to invocations from the entry points module, orchestrating the flows to the gateways.
  """
  require Logger

  alias PocketInformation.Domain.Gateways.PocketRepository
  alias PocketInformation.Domain.Gateways.CategoryRepository
  alias PocketInformation.Domain.Model.Pocket.Pocket
  alias PocketInformation.Domain.Model.Account.Account

  @doc """
  Function that will execute the use case.
  First, of all, the account conditions are queried, then those conditions are validated,
  if the validate_account method returns ok, The pocket information is retrieved, after that,
  the category reference is queried to category repository to enrich the pocket entity.
  Finally, the pocket and account domain entities is updated
  """
  def handle_use_case(account, traceability) do
    Logger.debug("Ejecutando el caso de uso: consultar informacion de bolsillo")

    with {:ok, pocket} <- PocketRepository.get_pocket(account),
         {:ok, category} <- CategoryRepository.get_category(pocket.category) do
      account_updated = Pocket.update_category(category, pocket) |> Account.update_pocket(account)
      {:ok, account_updated}
    else
      {:error, error} ->
        {:error, error}
    end
  end
end
