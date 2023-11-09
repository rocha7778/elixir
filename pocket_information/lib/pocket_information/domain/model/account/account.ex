defmodule PocketInformation.Domain.Model.Account.Account do
  alias PocketInformation.Domain.Model.Pocket.Pocket

  @derive Jason.Encoder
  defstruct [
    :type,
    :number,
    :pocket
  ]

  @type t :: %__MODULE__{
          type: String.t(),
          number: String.t(),
          pocket: Pocket.t()
        }

  def new(type, number, pocked_id) do
    with {:ok, pocket} <- Pocket.new(pocked_id) do
      {:ok,
       %__MODULE__{
         type: type,
         number: number,
         pocket: pocket
       }}
    end
  end

  def update_pocket(pocket, account) do
    %{account | pocket: pocket}
  end
end
