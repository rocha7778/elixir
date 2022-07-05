defmodule Dcal do
  def calculadora(contador)do
    receive do
     {pid,:add,a,b}->send(pid,a+b)
     {pid,:rest,a,b}->send(pid,a-b)
     {pid,:mul,a,b}->send(pid,a*b)
     {_pid,:div,_a,0}->exit("division por cero")
     {pid,:div,a,b}->send(pid,a/b)
     {pid,:cont}->send(pid,contador)
   end
    calculadora(contador+1)
  end
end
