defmodule PocketInformation.Test.Utils.HTTP.CowboyUtilsTest do
  @moduledoc false

  alias PocketInformation.Utils.HTTP.CowboyUtils
  alias PocketInformation.Utils.SSL.CertUtils
  alias PocketInformation.Test.Support.TestStubs

  import Mock
  use ExUnit.Case

  describe "build_child_spec/2" do
    test "build a child spec for prod env containing a mtls configuration for cowboy" do
      expected_response = TestStubs.cowboy_mtls_child_spec(__MODULE__)
      assert expected_response == CowboyUtils.build_child_spec(:prod, __MODULE__)
    end

    test "build a child spec for dev env containing a http configuration for cowboy" do
      expected_response = TestStubs.cowboy_http_child_spec(:dev, __MODULE__)
      result = CowboyUtils.build_child_spec(:dev, __MODULE__)
      assert expected_response == result
    end

    test "build a child spec for test env containing a EMPTY configuration for cowboy" do
      expected_response = TestStubs.cowboy_http_child_spec(:test, __MODULE__)
      result = CowboyUtils.build_child_spec(:test, __MODULE__)
      assert expected_response == result
    end
  end
end
