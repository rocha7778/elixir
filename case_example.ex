defmodule CaseExample do

  def test do

    map = xml()

    new_map =
      map
      |> get_in(["tns:esbXML"])
      |> get_in(["Header"])
      |> get_in(["interactionData"])
      |> Map.put("timestamp" , "test")


    #%{ new_map | "timestamp" => "test"}





  end

  def xml do
    %{
      "tns:esbXML" => %{
        "Body" => %{
          "ns1:recuperarParametrizacionEquivalencias" => %{
            "requerimientoParametrizacion" => %{
              "criterioParametrizacion" => [
                %{"tipologia" => "ADRTP", "valorOrigen" => "1"},
                %{"tipologia" => "CONTROL TERCEROS", "valorOrigen" => "PEPE"}
              ],
              "encabezadoHomologacion" => %{
                "aplicacionDestino" => "CRM-VENTAS",
                "aplicacionOrigen" => "SVP",
                "sociedadDestino" => "1000",
                "sociedadOrigen" => "1000"
              }
            }
          }
        },
        "Header" => %{
          "interactionData" => %{"timestamp" => "2022-07-14T14:27:34"},
          "messageId" => "message id not specified",
          "requestData" => %{
            "destination" => %{
              "name" => "Service",
              "namespace" => "http://grupobancolombia.com/intf/Domain/Area/Service/V1.0",
              "operation" => "operation"
            },
            "userId" => %{"userName" => "user"}
          },
          "systemId" => "elixir"
        }
      }
    }
  end

end
