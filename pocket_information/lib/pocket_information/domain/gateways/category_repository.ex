defmodule PocketInformation.Domain.Gateways.CategoryRepository.Behaviour do
  @moduledoc """
  Defines the expected behavior of the infrastructure.
  """
  alias PocketInformation.Domain.Model.Pocket.Category

  @callback get_category(category :: Category.t()) ::
              {:ok, response :: String} | {:error, reason :: term}
end

defmodule PocketInformation.Domain.Gateways.CategoryRepository do
  @behaviour PocketInformation.Domain.Gateways.CategoryRepository.Behaviour

  @impl_module Application.compile_env!(:pocket_information, :category_repository_impl)

  @impl true
  defdelegate get_category(code), to: @impl_module
end
