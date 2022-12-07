defmodule PocketInformation.Domain.Model.Request do

  defstruct [
    :message_id,
    :ibm_client_id,
    :body
  ]

  def new(map) do
    %__MODULE__{
      message_id: map["message_id"],
      ibm_client_id: map["ibm_client_id"],
      body: map["body"]
    }
  end

end
