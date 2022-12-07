defmodule Todo.System do
  def start_link do
    # The Counter is a child started via Counter.start_link(0)
    children = [
      CreditCardInformation.Ecto.Repo,
      Counter
    ]

    opts = [strategy: :one_for_one, name: __MODULE__]

    Supervisor.start_link(
      children,
      opts
    )
  end
end
