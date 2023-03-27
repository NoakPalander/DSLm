defmodule DSLm do
  use DSLm.Complex, unit: :j

  def main do
    a = 10 + ~j<5>
    b = 20 + ~j<10>
    d = a * b
    IO.puts(DSLm.Complex.polar(d))
  end
end
