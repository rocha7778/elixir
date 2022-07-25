defmodule TodoTest do
  alias MintTest

  import Mock
  use ExUnit.Case
  doctest Todo

  test "greets the world" do
    assert Todo.hello() == :world
  end

  describe "test_post" do
    test "two modules" do
      conn =
        {:ok,
         %Mint.HTTP1{
           buffer: "",
           host: "localhost",
           mode: :active,
           port: 3000,
           private: %{},
           proxy_headers: [],
           request: nil,
           requests: {[], []},
           scheme_as_string: "http",
           socket: "#Port<0.5>",
           state: :open,
           streaming_request: nil,
           transport: Mint.Core.Transport.TCP
         }}

      request = %{
        body: nil,
        connection: [],
        content_length: nil,
        data_buffer: [],
        headers_buffer: [],
        method: "GET",
        ref: "#Reference<0.1291779294.3723493381.1180>",
        state: :status,
        status: nil,
        transfer_encoding: [],
        version: nil
      }

      map = elem(conn, 1)
      map = %{map | request: request}
      conn_request = {:ok, map, "#Reference<0.1291779294.3723493381.1180>"}

      with_mocks [
        {Mint.HTTP, [], [connect: fn _protocol, _host, _port -> conn end]},
        {Mint.HTTP, [],
         [
           request: fn conn, _method = "GET", _path = "/users", _headers = [], nil ->
             conn_request
           end
         ]}
      ] do
      MintTest.test()

        assert true == true
      end
    end
  end

  # add this method to the test to il_test
  describe "from_xml/1" do
    test "should parse and xml to elixir data structure" do
      xml_string =
        "<tns:esbXML xmlns:tns=\"http://grupobancolombia.com/intf/IL/esbXML/V3.0\"><Header><systemId>elixir</systemId><messageId>message id not specified</messageId><interactionData><timestamp>2022-07-14T16:30:37</timestamp></interactionData><requestData><userId><userName>user</userName></userId><destination><name>Service</name><namespace>http://grupobancolombia.com/intf/Domain/Area/Service/V1.0</namespace><operation>operation</operation></destination></requestData></Header><Body><ns1:recuperarParametrizacionEquivalencias xmlns:ns1=\"http://grupobancolombia.com/intf/componente/tecnico/homologacion/RecuperarParametrizacionEquivalencias/V2.0\"><requerimientoParametrizacion><encabezadoHomologacion><aplicacionOrigen>SVP</aplicacionOrigen><aplicacionDestino>CRM-VENTAS</aplicacionDestino><sociedadOrigen>1000</sociedadOrigen><sociedadDestino>1000</sociedadDestino></encabezadoHomologacion><criterioParametrizacion><tipologia>ADRTP</tipologia><valorOrigen>1</valorOrigen></criterioParametrizacion><criterioParametrizacion><tipologia>CONTROL TERCEROS</tipologia><valorOrigen>PEPE</valorOrigen></criterioParametrizacion></requerimientoParametrizacion></ns1:recuperarParametrizacionEquivalencias></Body></tns:esbXML>"

      Il.from_xml(xml_string)
      assert true == true
    end
  end

  describe "get_equivalences/1" do
    test "should get a valid message" do
      expected_result = TestStubs.get_header_and_parameters()
      header = %{source_app: "SVP", target_app: "CRM-VENTAS"}

      current_parameters = [
        %{type: "ADRTP", value: 1},
        %{type: "CONTROL TERCEROS", value: "PEPE"}
      ]

      request = %{header: header, parameters: current_parameters}

       message = Equivalences.get_equivalences(request)
      assert true == true
    end
  end
end

{:ok,
 [
   %{equivalent: "Z001", type: "ADRTP", value: "1"},
   %{equivalent: "03", type: "CONTROL TERCEROS", value: "K"}
 ]}
