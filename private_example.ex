defmodule TestPrivate do
  def double(a) do
    sum(a,a)
  end
  defp sum(a,b) do
    a+b
  end

  def suma2(a,b\\1) do
    a+b
  end

end
