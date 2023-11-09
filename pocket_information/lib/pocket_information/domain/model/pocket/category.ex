defmodule PocketInformation.Domain.Model.Pocket.Category do
  import PocketInformation.Domain.Validations

  @type t :: %__MODULE__{id: String.t(), reference: String.t()}

  @derive Jason.Encoder
  defstruct [
    :id,
    :reference
  ]

  def new(id_category, id_category_reference) do
    with {:ok, id_category_v} <- validate_type(id_category, :string) do
      {:ok,
       %__MODULE__{
         id: id_category_v,
         reference: id_category_reference
       }}
    end
  end
end
