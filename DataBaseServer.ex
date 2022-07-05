defmodule DatabaseServer do
  def start do
    spawn(fn _->loop())
  end
end
