defmodule CreateJsonFile do

  require Poison

  @moduledoc """
  Documentation for `CreateJsonFile`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> CreateJsonFile.hello()
      :world

  """
  def hello do
    :world
  end

  def create_json_file(numbers) do
    data = %{
      "Tipo_de_cuenta" => "S",
      "Numero_de_Cuenta" => %{"$numberLong" => ""},
      "Codigo_del_bolsillo" => 1,
      "Nombre_del_bolsillo" => "SEGURO",
      "Codigo_de_categoria" => 2,
      "Estado_del_bolsillo" => "A",
      "Fecha_inicio_ahorro" => 0,
      "Fecha_fin_ahorro" => 0,
      "Transferencia_programada" => "N",
      "Periodicidad_ahorro" => "",
      "Dia_trans__programada" => 0,
      "Fecha_inicio_trans_programada" => 0,
      "Fecha_fin_trans_programada" => 0,
      "Fecha_Cancelacion" => 0,
      "Valor_total_de_la_Meta" => 150,
      "Valor_trans__programada" => 0,
      "Saldo_del_bolsillo" => 0,
      "Campo_Libre_1" => nil,
      "Campo_Libre_2" => nil,
      "Campo_Libre_3" => nil,
      "Usuario_de_creacion" => "braquint",
      "Fecha_de_creacion" => 20230411,
      "Hora_de_creacion" => 111652,
      "Usuario_de_modificacion" => nil,
      "Fecha_de_modificacion" => 0,
      "Hora_de_modificacion" => nil
    }

    json_data = for number <- numbers do
      Map.put(data, "Numero_de_Cuenta", %{"$numberLong" => to_string(number)})
      |> Poison.encode!
    end


    filename = "output.json"
    File.write!(filename, "#{Enum.join(json_data, ",\n")}\n")

  end
end

array = [4074618919,40674618920,40674618921,40674618922,40674618923,40674618924,40674618925,40674618926,40674618927,40674618928,40674618929,40674618930,40674618931,40674618932,40674618933,40674618934,40674618935,40674618936,40674618937,40674618938,40674618939,40674618940,40674618941,40674618942,40674618943,40674618944,40674619110,40674619111,40674619112,40674619113,40674619114,40674619115,40674619116,40674619117,40674619118,40674619119,40674619120,40674619121,40674619122,40674619123,40674619124,40674619125,40674619126,40674619127,40674619128,40674619129,40674619130,40674619131,40674619132,40674619133,40674619134,40674619135,40674619136,40674619137,40674619138,40674619139,40674619140]
CreateJsonFile.create_json_file(array)
