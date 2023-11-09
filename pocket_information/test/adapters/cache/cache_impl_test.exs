defmodule PocketInformation.Test.Adapters.Cache.CacheImplTest do
  use ExUnit.Case

  alias PocketInformation.Adapters.Cache.CacheImpl

  describe "creation of ets" do
    test "cache should be created" do
      expected = :bvdffblcat
      assert expected == CacheImpl.start()
    end
  end

  describe "operations on the cache " do
    test "should insert a value in cache" do
      CacheImpl.start()
      reference = {1, "stethoscope"}
      assert true == CacheImpl.insert(reference)
    end

    test "should consult the cache without finding value " do
      CacheImpl.start()
      expected = {:error, :reference_not_cached}
      assert expected == CacheImpl.get_reference(8)
    end
  end
end
