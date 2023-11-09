defmodule PocketInformation.Test.Support.TestStubs do
  alias PocketInformation.Domain.Model.Account.Account
  alias PocketInformation.Domain.Model.Account.AccountConditions

  # Mock for entry entry points http rest
  def account_request do
    %{
      "data" => [
        %{
          "account" => %{
            "number" => "123456789",
            "type" => "CUENTA_DE_AHORRO",
            "pocket" => %{"number" => "1234567891"}
          }
        }
      ]
    }
  end

  def account_request_pocket_not_found do
    %{
      "data" => [
        %{
          "account" => %{
            "number" => "5126323",
            "type" => "CUENTA_DE_AHORRO",
            "pocket" => %{"number" => "51263232"}
          }
        }
      ]
    }
  end

  def account_request_internal_server_error do
    %{
      "data" => [
        %{
          "account" => %{
            "number" => "5126329",
            "type" => "CUENTA_DE_AHORRO",
            "pocket" => %{"number" => "51263292"}
          }
        }
      ]
    }
  end

  def account_bad_request do
    %{
      "data" => [
        %{"account" => %{"number" => "91200244139"}}
      ]
    }
  end

  def account_missing_pocket_field do
    %{
      "data" => [
        %{"account" => %{"number" => "55131428291", "type" => "CUENTA_CORRIENTE"}}
      ]
    }
  end

  def account_request_pocket_number_max_lengt_exceeded do
    %{
      "data" => [
        %{
          "account" => %{
            "number" => "91200244139",
            "type" => "CUENTA_DE_AHORRO",
            "pocket" => %{"number" => "0000000406724739001123"}
          }
        }
      ]
    }
  end

  def account_request_account_number_max_lengt_exceeded do
    %{
      "data" => [
        %{
          "account" => %{
            "number" => "912002441392345674",
            "type" => "CUENTA_DE_AHORRO",
            "pocket" => %{"number" => "912002441392"}
          }
        }
      ]
    }
  end

  def pocket_prefix_number_is_not_equal_to_account_number_request do
    %{
      "data" => [
        %{
          "account" => %{
            "number" => "91200244139",
            "type" => "CUENTA_DE_AHORRO",
            "pocket" => %{"number" => "9120024413852"}
          }
        }
      ]
    }
  end

  def account_close_json_response do
    {:ok,
     [
       """
       {
        "meta": {
          "_messageId": "c4e6bd04-5149-11e7-b114-b2f933d5fe66",
          "_requestTimeStamp": "2017-01-24T05:00:00.000Z",
          "_applicationId": "acxff62e-6f12-42de-9012-3e7304418abd",
          "_responseSize": 1,
          "_version": "3.0"
        },
        "data": [
          {
            "header": {
              "type": "Account-Accounts",
              "id": "Account-Accounts-2017-01-24T05:00:00.000Z"
            },
            "account": {
              "inactiveDays": "0",
              "allowDebit": true,
              "allowCredit": true,
              "isClosed": true
            }
          }
        ],
        "links": {
          "self": "http://nues.ht/uwu"
        }
       }
       """
     ]}
  end

  def account_is_not_savings_account do
    %{
      "data" => [
        %{
          "account" => %{
            "number" => "91200244139",
            "type" => "CUENTA_CORRIENTE",
            "pocket" => %{"number" => "9120024413952"}
          }
        }
      ]
    }
  end

  # Mock for adapters http account_condition
  def account_detail do
    account_type = "CUENTA_DE_AHORRO"
    account_number = "91200244139"
    account_pocket_number = "912002441392"
    Account.new(account_type, account_number, account_pocket_number)
  end

  def account_conditions do
    {:ok, account_condition} =
      AccountConditions.new(%{
        "inactive_days" => "0",
        "allow_debit" => true,
        "allow_credit" => true,
        "is_closed" => false
      })

    account_condition
  end

  def account_condition_json_response do
    {:ok,
     [
       """
       {
        "meta": {
          "_messageId": "c4e6bd04-5149-11e7-b114-b2f933d5fe66",
          "_requestTimeStamp": "2017-01-24T05:00:00.000Z",
          "_applicationId": "acxff62e-6f12-42de-9012-3e7304418abd",
          "_responseSize": 1,
          "_version": "3.0"
        },
        "data": [
          {
            "header": {
              "type": "Account-Accounts",
              "id": "Account-Accounts-2017-01-24T05:00:00.000Z"
            },
            "account": {
              "inactiveDays": "0",
              "allowDebit": true,
              "allowCredit": true,
              "isClosed": false
            }
          }
        ],
        "links": {
          "self": "http://nues.ht/uwu"
        }
       }
       """
     ]}
  end

  def account_condition_error_json_response do
    {:ok,
     [
       """
       {
        "meta": {
          "_messageId": "c4e6bd04-5149-11e7-b114-b2f933d5fe66",
          "_requestTimeStamp": "2017-01-24T05:00:00.000Z",
          "_applicationId": "acxff62e-6f12-42de-9012-3e7304418abd",
          "_responseSize": 1,
          "_version": "3.0"
        },
        "errors": [
          {
            "id": "5f2d287a-3a3f-11e7-a919-92ebcb67fe33",
            "href": "https://tools.ietf.org/html/rfc7231#section-6.5.4",
            "status": "503",
            "code": "B503",
            "title": "Service unavailable",
            "detail": "Service unavailable"
          }
        ]
       }
       """
     ]}
  end

  def pocket_from_db do
    %{
      _id: "S51263283",
      Tipo_de_cuenta: "S",
      Numero_de_Cuenta: 5_126_329,
      Codigo_del_bolsillo: 2,
      Nombre_del_bolsillo: "FRANCIA M",
      Codigo_de_categoria: 5,
      Estado_del_bolsillo: "A",
      Fecha_inicio_ahorro: 20_190_711,
      Fecha_fin_ahorro: 20_200_711,
      Transferencia_programada: "N",
      Periodicidad_ahorro: "",
      Fecha_inicio_trans_programada: 20_220_728,
      Fecha_fin_trans_programada: 20_220_728,
      Fecha_Cancelacion: 20_220_728,
      Valor_total_de_la_Meta: 20000,
      Saldo_del_bolsillo: 0,
      Campo_Libre_1: "",
      Campo_Libre_2: "",
      Campo_Libre_3: "",
      Usuario_de_creacion: "CLCROZO",
      Fecha_de_creacion: 20_190_711,
      Hora_de_creacion: 154_943,
      Usuario_de_modificacion: "",
      Fecha_de_modificacion: 20_220_728,
      Hora_de_modificacion: 0,
      Dia_trans__programada: 0,
      Valor_trans__programada: 0
    }
  end

  def cowboy_mtls_child_spec(plug) do
    [
      {Plug.Cowboy,
       scheme: :https,
       plug: plug,
       options: [
         port: 8080,
         cipher_suite: :strong,
         password: "123456789",
         certfile: "./priv/ssl/depositosservices.pem",
         keyfile: "./priv/ssl/depositos.key",
         verify: :verify_peer,
         fail_if_no_peer_cert: true,
         cacertfile: "./priv/ssl/ca.depositosservices.pem"
       ]}
    ]
  end

  def cowboy_http_child_spec(:dev, plug) do
    [{Plug.Cowboy, scheme: :http, plug: plug, options: [port: 8080]}]
  end

  def cowboy_http_child_spec(:test, plug) do
    []
  end

  def body_params do
    %{
      "data" => [
        %{
          "account" => %{
            "number" => "91200244139",
            "pocket" => %{"number" => "912002441392"},
            "type" => "CUENTA_DE_AHORRO"
          }
        }
      ]
    }
  end

  def invalid_body_params do
    %{
      "data_x" => [
        %{
          "account_x" => %{
            "number" => "91200244139",
            "pocket" => %{"number" => "912002441392"},
            "type" => "CUENTA_DE_AHORRO"
          }
        }
      ]
    }
  end

  # Mocks para plug header traceability

  def header_without_message_id do
    [
      {"user-agent", "PostmanRuntime/7.29.2"},
      {"postman-token", "960fb471-9498-49db-a60a-87285d9a4b65"},
      {"message-id", "303de690-4393-11ed-8840-4865ee179d71"},
      {"host", "localhost:8080"},
      {"content-type", "application/vnd.bancolombia.v3+json"},
      {"content-length", "319"},
      {"connection", "keep-alive"},
      {"authorization", "Basic YWRtaW46YWRtaW4="},
      {"accept-encoding", "gzip, deflate, br"},
      {"accept", "application/vnd.bancolombia.v3+json"}
    ]
  end

  def header_with_message_id_value do
    [
      {"accept", "application/vnd.bancolombia.v3+json"},
      {"accept-encoding", "gzip, deflate, br"},
      {"authorization", "Basic YWRtaW46YWRtaW4="},
      {"connection", "keep-alive"},
      {"content-length", "319"},
      {"content-type", "application/vnd.bancolombia.v3+json"},
      {"host", "localhost:8080"},
      {"message-id", "b9757392-2322-11ed-861d-0242ac1200023"},
      {"postman-token", "b7b96403-de02-4090-8028-f28f9c6f74b4"},
      {"user-agent", "PostmanRuntime/7.29.2"}
    ]
  end

  def header_with_message_id_value_empty do
    [
      {"accept", "application/vnd.bancolombia.v3+json"},
      {"accept-encoding", "gzip, deflate, br"},
      {"authorization", "Basic YWRtaW46YWRtaW4="},
      {"connection", "keep-alive"},
      {"content-length", "319"},
      {"content-type", "application/vnd.bancolombia.v3+json"},
      {"host", "localhost:8080"},
      {"message-id", ""},
      {"postman-token", "b7b96403-de02-4090-8028-f28f9c6f74b4"},
      {"user-agent", "PostmanRuntime/7.29.2"}
    ]
  end
end
