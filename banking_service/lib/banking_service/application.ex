defmodule BankingService.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      Repo,
      Financial,
      Sender
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: BankingService.Supervisor]
    Supervisor.start_link(children, opts)
  end
end

# Process.whereis(Repo)
# Process.whereis(Financial)
# Process.whereis(Financial.Account)
# Process.whereis(Financial.Transfer)
# Process.whereis(Sender)

# pid = Process.whereis(Financial.Transfer)
# Process.exit(pid, :kill)
