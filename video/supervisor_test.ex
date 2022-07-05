defmodule  Supervisame do
  use Supervisor


  def start_link(_arg) do
    IO.puts("[Supervisame Iniciando]")
    Supervisor.start_link(
      [{GCalc,[]}],
      strategy: :one_for_one)
  end

end
