defmodule DSLm.Complex do
  alias DSLm.Complex.Rect, as: Rect
  alias DSLm.Complex.Polar, as: Polar

  require Rect
  require Polar

  defmacro __using__(unit: unit) do
    quote do
      import unquote(__MODULE__)

      use DSLm.Complex.Evaluator

      unit = unquote(unit)
      def unquote(:"sigil_#{Atom.to_string(unit)}")(str, _) do
        num =
          with int <- String.to_integer(str) do
            int
          else
            _ ->
              String.to_float(str)
          end

        %DSLm.Complex.Rect{real: 0, imag: num}
      end
    end
  end

  defmacro is_complex(a) do
    quote do
      Rect.is_rect(unquote(a)) or Polar.is_polar(unquote(a))
    end
  end

  def polar(c), do: Polar.to_polar(c)
  def rect(c), do: Rect.to_rect(c)
end
