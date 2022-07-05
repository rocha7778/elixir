defmodule Mathematic do
  @pi 3.14159
  def increment(n)do
    n+1
  end
  def circle_area(radio) do
    double(radio)*@pi
  end

  defp double(a) do
    a*a
  end

  def perimeter(radio) do
    2*@pi*radio
  end
end
