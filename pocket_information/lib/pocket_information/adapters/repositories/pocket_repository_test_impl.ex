defmodule PocketInformation.Adapters.Repositories.PocketRepositoryTestImpl do
  @behaviour PocketInformation.Domain.Gateways.PocketRepository.Behaviour

  alias PocketInformation.Domain.Model.Pocket.Pocket
  alias PocketInformation.Domain.Model.Account.Account

  @impl true
  @impl true
  def get_pocket(_account) do
    Pocket.new(
      "1234567892",
      "Vacaciones",
      "2022-09-01",
      "2023-09-01",
      "ACTIVO",
      Decimal.from_float(12000.0),
      Decimal.from_float(0.0),
      "2022-09-01",
      nil,
      "005",
      "car",
      "SEMANAL",
      1,
      "2022-09-01",
      "2023-09-01",
      Decimal.from_float(1000.0)
    )
  end

end
