defmodule Todo.Application do
  @moduledoc """
  Main entry point of the app
  """

  use Application
  require Logger

  @doc """
  Start the supervisor with a Postgres Database and a HTTP server
  """
  def start(_, _) do
    Todo.System.start_link()
  end
end
