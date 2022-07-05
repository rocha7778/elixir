defmodule Empresa.Writer do
  alias Empresa.Empleado, as: Empleado
  import JSON
  defp to_map(%Empleado {nombre: n, posicion: p, sueldo: s}) do
    %{"nombre"=>n, "posicion"=>p, "sueldo"=>s}
  end

  defp to_map(_x) do
    {:err, "The type of variable provided not match with Empleado "}
  end


  defp to_json(m) do
    {:ok, json_version} = encode(m)
    json_version
  end

  defp dump(str) do
    File.write("empleados.json", str)
  end

  def write (empleados) do
    empleados |>
    Enum.map(fn x -> to_map(x) end) |>
    Enum.filter(fn x -> x != nil end) |>
    to_json |>
    dump
  end

end

e1= %Empresa.Empleado{nombre: "Pepa",posicion: "Contabilidad",sueldo: 38000}
e2= %Empresa.Empleado{nombre: "Rocha",posicion: "Venta",sueldo: 43000}
e3= %Empresa.Empleado{nombre: "Ana",posicion: "Gerente",sueldo: 55000}
e4= %Empresa.Empleado{nombre: "Diego",posicion: "Informatica",sueldo: 42000}

empleados = [e1,e2,e3,e4]

Empresa.Writer.write(empleados)
