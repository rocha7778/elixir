defmodule PocketInformation.Adapters.Repositories.CategoryRepositoryTestImpl do
  @behaviour PocketInformation.Domain.Gateways.CategoryRepository.Behaviour

  alias PocketInformation.Domain.Model.Pocket.Category

  @impl true
  def get_category(category) do
    Category.new("0001", "stethoscope")
  end
end
