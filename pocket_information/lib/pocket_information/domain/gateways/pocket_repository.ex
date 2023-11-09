defmodule PocketInformation.Domain.Gateways.PocketRepository.Behaviour do
  @moduledoc """
  Defines the expected behavior of the infrastructure.
  """

  alias PocketInformation.Domain.Model.Account.Account
  alias PocketInformation.Domain.Model.Pocket.Pocket

  @callback get_pocket(Account.t()) ::
              {:ok, pocket :: Pocket.t()} | {:error, reason :: term}
end

defmodule PocketInformation.Domain.Gateways.PocketRepository do
  @behaviour PocketInformation.Domain.Gateways.PocketRepository.Behaviour

  @impl_module Application.compile_env!(:pocket_information, :pocket_repository_impl)

  @impl true
  defdelegate get_pocket(account), to: @impl_module
end
