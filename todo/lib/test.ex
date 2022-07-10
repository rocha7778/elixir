defmodule Test do
  def total_sueldos do
    with {:ok, file} <- File.read("comments.json"),
         {:ok, data} <- Jason.decode(file),
         {:ok, empl} <- Map.fetch(data,"a")
          do

          empl |> Enum.map(fn k -> k["sueldo"] end) |> Enum.sum
    end
  end

  def to_json do
    map = %{"empleado" => [ %{nombre: "rocha", apellido: "Luna", sueldo: 3500}]}
    json = Jason.encode!(map)

    {:ok, file} = File.read("comments.json")

   {:ok, json_to_elix} = Jason.decode(file)

    Map.fetch!(json_to_elix, "a") |> Enum.map(fn k ->k["sueldo"] end) |> Enum.sum()
  end



end
