defmodule DSLm.Complex.Evaluator do
  import Additive
  import AddGroup
  import Multiplicative
  import MulGroup

  defmacro __using__(_opts) do
    quote do
      import Kernel, except: [+: 2, -: 2, *: 2, /: 2]
      import unquote(__MODULE__)
    end
  end

  def a + b, do: add(a, b)
  def a - b, do: sub(a, b)
  def a * b, do: mul(a, b)
  def a / b, do: divide(a, b)
end
