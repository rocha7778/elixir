defmodule PocketInformation.Utils.HTTP.NullFieldRemoverTest do
  import Mock
  alias PocketInformation.Test.Support.TestStubsNullRemover
  alias PocketInformation.Utils.HTTP.NullFieldRemover
  use ExUnit.Case

  describe "remove_fields/" do
    test "should remove closeDate from pocket struct" do
      body = TestStubsNullRemover.pocket_with_null_values()
      body_response = NullFieldRemover.remove_fields(body)
      body_map = List.first(body_response.data)
      pocket = body_map.account.pocket
      assert nil == Map.get(pocket, :closedDate)
      assert nil == Map.get(pocket, :savingsGoal)
      assert nil != Map.get(pocket, :number)
    end
    test "should remove savingsEndDay from date struct" do
      body = TestStubsNullRemover.pocket_with_null_values()
      body_response = NullFieldRemover.remove_fields(body)
      body_map = List.first(body_response.data)
      pocket = body_map.account.pocket.dates
      assert nil == Map.get(pocket, :savingsEndDate)
      assert nil != Map.get(pocket, :savingsStartDate)
    end
    test "should keep savingsEndDay from date struct" do
      body = TestStubsNullRemover.pocket_with_savings_end_date_values()
      body_response = NullFieldRemover.remove_fields(body)
      body_map = List.first(body_response.data)
      pocket = body_map.account.pocket.dates
      assert nil != Map.get(pocket, :savingsEndDate)
    end
    test "should keep closeDay from date struct" do
      body = TestStubsNullRemover.pocket_with_close_date_values()
      body_response = NullFieldRemover.remove_fields(body)
      body_map = List.first(body_response.data)
      pocket = body_map.account.pocket
      assert nil != Map.get(pocket, :closedDate)
    end
    test "should keep frequency from date struct" do
      body = TestStubsNullRemover.pocket_with_frequency_values()
      body_response = NullFieldRemover.remove_fields(body)
      body_map = List.first(body_response.data)
      pocket = body_map.account.pocket.scheduledTransfer
      assert nil != Map.get(pocket, :frequency)
    end
    test "should keep startDate from date struct" do
      body = TestStubsNullRemover.pocket_with_startDate_values()
      body_response = NullFieldRemover.remove_fields(body)
      body_map = List.first(body_response.data)
      pocket = body_map.account.pocket.scheduledTransfer
      assert nil != Map.get(pocket, :startDate)
    end
    test "should keep endDate from date struct" do
      body = TestStubsNullRemover.pocket_with_end_date_values()
      body_response = NullFieldRemover.remove_fields(body)
      body_map = List.first(body_response.data)
      pocket = body_map.account.pocket.scheduledTransfer
      assert nil != Map.get(pocket, :endDate)
    end

    test "should remove frequency, startDateTransfer and endDateTransfer from scheduledTransfer" do
      body = TestStubsNullRemover.pocket_with_null_values()
      body_response = NullFieldRemover.remove_fields(body)
      body_map = List.first(body_response.data)
      pocket = body_map.account.pocket.scheduledTransfer
      assert nil == Map.get(pocket, :frequency)
      assert nil == Map.get(pocket, :startDate)
      assert nil == Map.get(pocket, :endDate)
      assert nil != Map.get(pocket, :day)
    end
  end
end
