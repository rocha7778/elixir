defmodule Example.Behaviour.SaludadorInFormalImp do

  @behaviour Example.Behaviour.Saludador

  @impl true
  def saludar(nombre) do
    "Que mas pues, #{nombre}"
  end


end
