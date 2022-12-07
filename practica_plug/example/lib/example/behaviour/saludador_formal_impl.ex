defmodule Example.Behaviour.SaludadorFormalImp do

  @behaviour Example.Behaviour.Saludador

  @impl true
  def saludar(nombre) do
    "Hola, buenos dias #{nombre}, como has estado"
  end


end
