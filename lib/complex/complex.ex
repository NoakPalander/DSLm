defmodule DSLm.Complex do
  alias DSLm.Complex.Rect, as: Rect
  alias DSLm.Complex.Polar, as: Polar

  require Rect
  require Polar

  defmacro __using__(unit: unit) do
    quote do
      import Kernel, except: [+: 2, -: 2, *: 2, /: 2, **: 2]
      import unquote(__MODULE__)

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

  def a + b when is_complex(a) and is_complex(b) do
    Rect.add(Rect.to_rect(a), Rect.to_rect(b))
  end

  def a + b when is_complex(a) do
    Rect.add(Rect.to_rect(a), b)
  end

  def a + b when is_complex(b) do
    Rect.add(a, Rect.to_rect(b))
  end

  def a + b do
    Kernel.+(a, b)
  end

  def a - b when is_complex(a) and is_complex(b) do
    Rect.sub(Rect.to_rect(a), Rect.to_rect(b))
  end

  def a - b when is_complex(a) do
    Rect.sub(Rect.to_rect(a), b)
  end

  def a - b when is_complex(b) do
    Rect.sub(a, Rect.to_rect(b))
  end

  def a - b do
    Kernel.-(a, b)
  end

  def a * b when is_complex(a) and is_complex(b) do
    Polar.mul(Polar.to_polar(a), Polar.to_polar(b)) |> Rect.to_rect()
  end

  def a * b when is_complex(a) do
    Polar.mul(Polar.to_polar(a), b) |> Rect.to_rect()
  end

  def a * b when is_complex(b) do
    Polar.mul(a, Polar.to_polar(b)) |> Rect.to_rect()
  end

  def a * b do
    Kernel.*(a, b)
  end

  def a / b when is_complex(a) and is_complex(b) do
    Polar.div(Polar.to_polar(a), Polar.to_polar(b)) |> Rect.to_rect()
  end

  def a / b when is_complex(a) do
    Polar.div(Polar.to_polar(a), b) |> Rect.to_rect()
  end

  def a / b when is_complex(b) do
    Polar.div(a, Polar.to_polar(b)) |> Rect.to_rect()
  end

  def a / b do
    Kernel./(a, b)
  end

  def a ** b when is_complex(a) and is_number(b) do
    Polar.pow(Polar.to_polar(a), b) |> Rect.to_rect()
  end

  def a ** b do
    Kernel.**(a, b)
  end
end
