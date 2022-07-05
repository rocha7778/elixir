defmodule Supervisame.Pila do
  use GenServer
  alias Supervisame.Calculadora

  def start_link(calc),do: GenServer.start_link(__ MODULE__,calc)

  def push(pid,val),do: GenServer.call(pid,{:push,val})

  def init(calc)do
     10.puts"[Pila]Iniciando GenServer"
     {:ok,{calc,}}
  end

  def handle_call({:push,:add},_from,{calc,[a,bIstack]})do
     10.puts"[Pila]Push ADD"
     resul Calculadora.add(calc,a,b)
     {:reply,resul,{calc,[resulIstack]}}
  end

  def handle_call({:push,:sub},_from,{calc,[a,bl stack]})do
     10.puts"[Pila]Push SUB"
     resul=Calculadora.sub(calc,a,b)
    {:reply,resul,{calc,[resulIstack]}}
  end

  def handle_call({:push,:mul},_from,{calc,[a,bIstack]})do
     10.puts"[Pila]Push MUL"
     resul Calculadora.mul(calc,a,b)
     {:reply,resul,{calc,[resulIstack]}}
  end

  def handle_call({:push,:div},_from,{calc,[a,b|stack]})do
     10.puts"[Pila]Push DIV"
     resul=Calculadora.div(calc,a,b)
     {:reply,resul,{calc,[resulIstack]}}
  end

  def handle_call({:push,x},_from,{calc,stack})when is_number(x)do
     10.puts"[Pila]Push#{x}"
     {:reply,x,{calc,[xIstack]}}
  end
 end
