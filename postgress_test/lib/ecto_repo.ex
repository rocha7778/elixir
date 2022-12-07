defmodule CreditCardInformation.Ecto.Repo do
  @moduledoc """
  Has the ecto configuration repo configuration: this module will set Postgres as the database adapter.
  """
  use Ecto.Repo,
    otp_app: :postgress_test,
    adapter: Ecto.Adapters.Postgres
end
