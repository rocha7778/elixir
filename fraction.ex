defmodule Fraction do
  defstruct [a: nil, b: nil]

  def new(a, b) do
    %Fraction{a: a, b: b}
  end

  def value(%Fraction{a: a, b: b}) do
    a / b
  end

  def add(%Fraction{a: a1, b: b1}, %Fraction{a: a2, b: b2}) do
    new(
      a1 * b2 + a2 * b1,
      b2 * b1
    )
  end
end

one_half = %Fraction{a: 1, b: 2}
on_half =  %Fraction{a: 1, b: 2}

Juric, Sasa. Elixir in Action (p. 217). Manning. Kindle Edition.
