case Enum.find([1,2,3,4,5], fn x -> match?(6,x) end) do
  5 -> IO.puts( "encontro el 5")
  nil -> IO.puts(" no ha encontrado el valor")
end

# actualizar un campo de una map
map = %{one: 1, two: 2}
%{map | one: "one"}

File.read("comments.json")