defmodule PocketInformation.Test.Adapters.Repositories.PocketRepositoryImplTest do
  use ExUnit.Case

  import Mock

  alias PocketInformation.Adapters.Repositories.PocketRepositoryImpl
  alias PocketInformation.Domain.Model.Account.Account
  alias PocketInformation.Domain.Model.Pocket.Pocket
  alias PocketInformation.Test.Support.TestStubs

  describe "get_pocket" do
    test "should return a valid pocket" do
      {:ok, account} = Account.new("CUENTA_DE_AHORRO", "123456789", "1234567891")

      with_mocks [
        {Mongo, [], [find: fn _topology_pid, _coll, _filter -> [TestStubs.pocket_from_db()] end]}
      ] do
        {:ok, %Pocket{number: number, name: name, state: state}} =
          PocketRepositoryImpl.get_pocket(account)

        assert number == "51263292"
        assert name == "FRANCIA M"
        assert state == "ACTIVO"
      end
    end

    test "should return an error if any pocket if retrieved from mongo" do
      {:ok, account} = Account.new("CUENTA_DE_AHORRO", "123456789", "1234567891")

      with_mocks [
        {Mongo, [], [find: fn _topology_pid, _coll, _filter -> [] end]}
      ] do
        assert {:error, :pocket_not_found} ==
                 PocketRepositoryImpl.get_pocket(account)
      end
    end

    test "should return an error if an error ocurred homologating the pocket state" do
      pocket_from_mongo_invalid_state = %{
        TestStubs.pocket_from_db()
        | Estado_del_bolsillo: "O"
      }

      {:ok, account} = Account.new("CUENTA_DE_AHORRO", "123456789", "1234567891")

      with_mocks [
        {Mongo, [],
         [find: fn _topology_pid, _coll, _filter -> [pocket_from_mongo_invalid_state] end]}
      ] do
        assert {:error, :internal_server_error} ==
                 PocketRepositoryImpl.get_pocket(account)
      end
    end

    test "should return a valid pocket if it was not possible to homologate the frequency field" do
      pocket_from_mongo = %{TestStubs.pocket_from_db() | Periodicidad_ahorro: "K"}
      {:ok, account} = Account.new("CUENTA_DE_AHORRO", "123456789", "1234567891")

      with_mocks [
        {Mongo, [], [find: fn _topology_pid, _coll, _filter -> [pocket_from_mongo] end]}
      ] do
        {:ok, %Pocket{number: number, name: name, state: state}} =
          PocketRepositoryImpl.get_pocket(account)

        assert number == "51263292"
        assert name == "FRANCIA M"
        assert state == "ACTIVO"
      end
    end

    test "should return an error if an error ocurred converting the start date" do
      pocket_from_mongo_invalid_date = %{
        TestStubs.pocket_from_db()
        | Fecha_de_creacion: "203212"
      }

      {:ok, account} = Account.new("CUENTA_DE_AHORRO", "123456789", "1234567891")

      with_mocks [
        {Mongo, [],
         [find: fn _topology_pid, _coll, _filter -> [pocket_from_mongo_invalid_date] end]}
      ] do
        assert {:error, :internal_server_error} ==
                 PocketRepositoryImpl.get_pocket(account)
      end
    end

    test "should return an error if an error ocurred building the pocket id" do
      pocket_from_mongo_invalid_pocked_id = %{
        TestStubs.pocket_from_db()
        | Codigo_del_bolsillo: "200"
      }

      {:ok, account} = Account.new("CUENTA_DE_AHORRO", "123456789", "1234567891")

      with_mocks [
        {Mongo, [],
         [find: fn _topology_pid, _coll, _filter -> [pocket_from_mongo_invalid_pocked_id] end]}
      ] do
        assert {:error, :internal_server_error} ==
                 PocketRepositoryImpl.get_pocket(account)
      end
    end
  end
end
