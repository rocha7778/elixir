defmodule PocketInformation.Test.EntryPoints.Http.Rest.ApiRestControllerTest do
  use ExUnit.Case
  use Plug.Test

  import Mock

  require Logger

  alias PocketInformation.EntryPoints.Http.Rest.ApiRestController
  alias PocketInformation.Adapters.Http.Client.HttpClient
  alias PocketInformation.Test.Support.TestStubs

  @opts ApiRestController.init([])

  describe "/v1/operations/product-specific/deposits/accounts/pockets/retrieve" do
    test "should return success server 200 status and return the pocket information" do
      expected_result = 200
      request_body = TestStubs.account_request()

      cnx =
        conn(
          :post,
          "/v1/operations/product-specific/deposits/accounts/pockets/retrieve",
          request_body
        )
        |> Plug.Conn.put_req_header("content-type", "application/vnd.bancolombia.v4+json")
        |> Plug.Conn.put_req_header("message-id", "c4e6bd04-5149-11e7-b114-b2f933d5fe66")
        |> Plug.Conn.put_req_header("authorization", "Basic YWRtaW46MTIz")

      result_response = ApiRestController.call(cnx, @opts)
      {:ok, response_body} = result_response.resp_body |> Jason.decode()
      assert result_response.status == expected_result
    end

    test "should not fail even when the message-id is not sent" do
      expected_result = 200
      request_body = TestStubs.account_request()

      cnx =
        conn(
          :post,
          "/v1/operations/product-specific/deposits/accounts/pockets/retrieve",
          request_body
        )
        |> Plug.Conn.put_req_header("content-type", "application/vnd.bancolombia.v4+json")
        |> Plug.Conn.put_req_header("authorization", "Basic YWRtaW46MTIz")

      result_response = ApiRestController.call(cnx, @opts)
      {:ok, response_body} = result_response.resp_body |> Jason.decode()
      assert result_response.status == expected_result
    end

    test "should return success server 404 status if the pocket is not found" do
      expected_result = 409
      request_body = TestStubs.account_request_pocket_not_found()

      cnx =
        conn(
          :post,
          "/v1/operations/product-specific/deposits/accounts/pockets/retrieve",
          request_body
        )
        |> Plug.Conn.put_req_header("content-type", "application/vnd.bancolombia.v4+json")
        |> Plug.Conn.put_req_header("message-id", "c4e6bd04-5149-11e7-b114-b2f933d5fe66")
        |> Plug.Conn.put_req_header("authorization", "Basic YWRtaW46MTIz")

      result_response = ApiRestController.call(cnx, @opts)
      {:ok, response_body} = result_response.resp_body |> Jason.decode()
      assert result_response.status == expected_result
    end

    test "should return success server 500 status if an error ocurred processing the request" do
      expected_result = 500
      request_body = TestStubs.account_request_internal_server_error()

      cnx =
        conn(
          :post,
          "/v1/operations/product-specific/deposits/accounts/pockets/retrieve",
          request_body
        )
        |> Plug.Conn.put_req_header("content-type", "application/vnd.bancolombia.v4+json")
        |> Plug.Conn.put_req_header("message-id", "c4e6bd04-5149-11e7-b114-b2f933d5fe66")
        |> Plug.Conn.put_req_header("authorization", "Basic YWRtaW46MTIz")

      result_response = ApiRestController.call(cnx, @opts)
      {:ok, response_body} = result_response.resp_body |> Jason.decode()
      assert result_response.status == expected_result
    end

    test "should return success server 404 status if the resource api is not found" do
      expected_result = 404
      request_body = TestStubs.account_request()

      cnx =
        conn(
          :post,
          "/unknown/resource",
          request_body
        )
        |> Plug.Conn.put_req_header("content-type", "application/vnd.bancolombia.v4+json")
        |> Plug.Conn.put_req_header("message-id", "c4e6bd04-5149-11e7-b114-b2f933d5fe66")
        |> Plug.Conn.put_req_header("authorization", "Basic YWRtaW46MTIz")

      result_response = ApiRestController.call(cnx, @opts)
      {:ok, response_body} = result_response.resp_body |> Jason.decode()
      assert result_response.status == expected_result
    end

    test "should return 400 status code bad request" do
      expected_result = 400
      request_body = TestStubs.account_bad_request()

      cnx =
        conn(
          :post,
          "/v1/operations/product-specific/deposits/accounts/pockets/retrieve",
          request_body
        )
        |> Plug.Conn.put_req_header("content-type", "application/vnd.bancolombia.v4+json")
        |> Plug.Conn.put_req_header("message-id", "c4e6bd04-5149-11e7-b114-b2f933d5fe66")
        |> Plug.Conn.put_req_header("authorization", "Basic YWRtaW46MTIz")

      result_response = ApiRestController.call(cnx, @opts)
      {:ok, response_body} = result_response.resp_body |> Jason.decode()
      assert result_response.status == expected_result
    end

    test "should return 400 status code bad request mising pocket field" do
      expected_result = 400
      request_body = TestStubs.account_missing_pocket_field()

      cnx =
        conn(
          :post,
          "/v1/operations/product-specific/deposits/accounts/pockets/retrieve",
          request_body
        )
        |> Plug.Conn.put_req_header("content-type", "application/vnd.bancolombia.v4+json")
        |> Plug.Conn.put_req_header("message-id", "c4e6bd04-5149-11e7-b114-b2f933d5fe66")
        |> Plug.Conn.put_req_header("authorization", "Basic YWRtaW46MTIz")

      result_response = ApiRestController.call(cnx, @opts)
      {:ok, response_body} = result_response.resp_body |> Jason.decode()
      assert result_response.status == expected_result
    end

    test "should return 400 status code bad request pocket number maxLength exceeded" do
      expected_result = 400
      request_body = TestStubs.account_request_pocket_number_max_lengt_exceeded()

      cnx =
        conn(
          :post,
          "/v1/operations/product-specific/deposits/accounts/pockets/retrieve",
          request_body
        )
        |> Plug.Conn.put_req_header("content-type", "application/vnd.bancolombia.v4+json")
        |> Plug.Conn.put_req_header("message-id", "c4e6bd04-5149-11e7-b114-b2f933d5fe66")
        |> Plug.Conn.put_req_header("authorization", "Basic YWRtaW46MTIz")

      result_response = ApiRestController.call(cnx, @opts)
      {:ok, response_body} = result_response.resp_body |> Jason.decode()
      assert result_response.status == expected_result
    end

    test "should return 400 status code bad request account number maxLength exceeded" do
      expected_result = 400
      request_body = TestStubs.account_request_account_number_max_lengt_exceeded()

      cnx =
        conn(
          :post,
          "/v1/operations/product-specific/deposits/accounts/pockets/retrieve",
          request_body
        )
        |> Plug.Conn.put_req_header("content-type", "application/vnd.bancolombia.v4+json")
        |> Plug.Conn.put_req_header("message-id", "c4e6bd04-5149-11e7-b114-b2f933d5fe66")
        |> Plug.Conn.put_req_header("authorization", "Basic YWRtaW46MTIz")

      result_response = ApiRestController.call(cnx, @opts)
      {:ok, response_body} = result_response.resp_body |> Jason.decode()
      assert result_response.status == expected_result
    end

    test "should return 400 status code bad request pocket prefix is not equal to account number" do
      expected_result = 400
      request_body = TestStubs.pocket_prefix_number_is_not_equal_to_account_number_request()

      cnx =
        conn(
          :post,
          "/v1/operations/product-specific/deposits/accounts/pockets/retrieve",
          request_body
        )
        |> Plug.Conn.put_req_header("content-type", "application/vnd.bancolombia.v4+json")
        |> Plug.Conn.put_req_header("message-id", "c4e6bd04-5149-11e7-b114-b2f933d5fe66")
        |> Plug.Conn.put_req_header("authorization", "Basic YWRtaW46MTIz")

      result_response = ApiRestController.call(cnx, @opts)
      {:ok, response_body} = result_response.resp_body |> Jason.decode()
      assert result_response.status == expected_result
    end

    test "should return 400 status code bad request account is not savings account  --" do
      expected_result = 400
      request_body = TestStubs.account_is_not_savings_account()

      cnx =
        conn(
          :post,
          "/v1/operations/product-specific/deposits/accounts/pockets/retrieve",
          request_body
        )
        |> Plug.Conn.put_req_header("content-type", "application/vnd.bancolombia.v4+json")
        |> Plug.Conn.put_req_header("message-id", "c4e6bd04-5149-11e7-b114-b2f933d5fe66")
        |> Plug.Conn.put_req_header("authorization", "Basic YWRtaW46MTIz")

      result_response = ApiRestController.call(cnx, @opts)
      IO.inspect(result_response, label: ".-.---------------------")
      {:ok, response_body} = result_response.resp_body |> Jason.decode()
      assert result_response.status == expected_result
    end
  end
end
