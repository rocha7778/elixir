lluvia = 110

mensaje = cond do
  lluvia == 0 -> "No ha llovido"
  lluvia < 30 -> "Ha llovido poco"
  lluvia < 60 -> "Ha llovido mucho"
  lluvia < 90 -> "Tormenta"
  true        -> "Valor invalido"

end

IO.puts(mensaje)
