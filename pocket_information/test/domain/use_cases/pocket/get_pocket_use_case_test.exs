defmodule PocketInformation.Test.Domain.UseCases.Pocket.GetPocketUseCaseTest do
  use ExUnit.Case

  import Mock

  alias PocketInformation.Domain.UseCases.Pocket.GetPocketUseCase
  alias PocketInformation.Domain.Model.Account.Account
  alias PocketInformation.Domain.Model.Pocket.Pocket
  alias PocketInformation.Test.Support.TestStubs

  describe "handle_use_case" do
    test "should return a pocket if" do
      {:ok, account} = Account.new("CUENTA_DE_AHORRO", "123456789", "1234567892")
      treacebility = %{message_id: "1234"}

      {:ok, %{pocket: %Pocket{number: number, name: name}}} =
        GetPocketUseCase.handle_use_case(account, treacebility)

      assert number == "1234567892"
      assert name == "Vacaciones"
    end

    test "should return a {:error, reason} tuple if something bad happens" do
      {:ok, account} = Account.new("CUENTA_DE_AHORRO", "5126328", "51263282")
      treacebility = %{message_id: "1234"}

      {:error, reason} = GetPocketUseCase.handle_use_case(account, treacebility)

      assert reason == :internal_server_error
    end
  end

end
