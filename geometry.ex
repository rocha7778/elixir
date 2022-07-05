defmodule Geometry do
  @pi 3.14159
  def area({:rectangle,a, b}) do
    a * b
  end
  def area({:square,l}) do
    area({:rectangle,l,l})
  end
  def area({:circle,radio}) do
      double(radio)*@pi
  end
  defp double(a) do
    a*a
  end
  def area(unknow)do
    {:error,{:unknown_shape,unknow}}
  end

end
