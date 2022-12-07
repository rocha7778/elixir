defmodule Test do
  def extract_user(user) do
    case Enum.filter(
           ["login", "email", "password"],
           &(not Map.has_key?(user, &1))
         ) do
      [] ->
        {:ok, %{
          login: user["login"],
          email: user["email"],
          password: user["password"]
        }}

      missing_fields ->
        {:error, "missing fields: #{Enum.join(missing_fields, ", ")}"}
    end
  end
end

multiplication_table =
  for x <- 1..9, y <- 1..9,
      into: %{} do
    {{x, y}, x*y}
  end
