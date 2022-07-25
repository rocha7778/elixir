defmodule LensTes do
  def test do
    list = [1, 2, 3]
    result = Lens.all() |> Lens.to_list(list)

    map = %{a: 1, b: [2, 3]}
    Lens.at(1) |> Lens.key(:a) |> Lens.to_list(map)

    # key_a = Lens.key(:a)
    # key_b_and_at_1 = Lens.key(:b)|> Lens.at(1)
    # lens1 = key_a |> key_b_and_at_1
    # Lens.both(lens1,Lens.to_list(map))

    IO.inspect(result)
  end

  def matchin(%{header: header, parameters: parameters, message_id: message_id}) do
    IO.puts("Header and parameters and messaged id")
  end

  def matchin(%{header: header, parameters: parameters}) do
    IO.puts("Header and parameters")
  end

  def test_with(map) do
    #m = %{a: 1, c: 3}
    m = map

    with {:ok, number} <- Map.fetch(m, :a),
         true <- rem(number, 2)==0 do
      IO.puts("#{number} divided by 2 is #{div(number, 2)}")
      :even
    else
      :error ->
        IO.puts("We don't have this item in map")
        :error

      _ ->
        IO.puts("It is odd")
        :odd
    end
  end
end

message_id = "b6ef9950-02e7-11ed-b1a0-4865ee179d71"
header = %{source_app: "SVP", target_app: "CRM-VENTAS"}
parameters = [%{type: "ADRTP", value: 1}, %{type: "CONTROL TERCEROS", value: "PEPE"}]

LensTes.matchin(%{header: header, parameters: parameters})
LensTes.matchin(%{header: header, parameters: parameters, message_id: message_id})
LensTes.test_with(%{a: 1, c: 3})
LensTes.test_with(%{a: 2, c: 2})
LensTes.test_with(%{b: 2, c: 2})
