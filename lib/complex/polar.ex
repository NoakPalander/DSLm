defmodule DSLm.Complex.Polar do
  defstruct mag: 0, angle: 0

  def new(mag, angle), do: %DSLm.Complex.Polar{mag: mag, angle: angle}

  defmacro is_polar(c) do
    quote do
      is_struct(unquote(c), unquote(__MODULE__))
    end
  end

  defmacrop is_rect(c) do
    quote do
      is_struct(unquote(c), DSLm.Complex.Rect)
    end
  end

  def mul(%DSLm.Complex.Polar{mag: r1, angle: a1}, %DSLm.Complex.Polar{mag: r2, angle: a2}) do
    new(r1 * r2, a1 + a2)
  end

  def mul(%DSLm.Complex.Polar{mag: r1, angle: a}, r2) do
    new(r1 * r2, a)
  end

  def mul(r1, %DSLm.Complex.Polar{mag: r2, angle: a}) do
    new(r1 * r2, a)
  end

  def div(%DSLm.Complex.Polar{mag: r1, angle: a1}, %DSLm.Complex.Polar{mag: r2, angle: a2}) do
    new(r1 / r2, a1 - a2)
  end

  def div(%DSLm.Complex.Polar{mag: r1, angle: a}, r2) do
    new(r1 / r2, a)
  end

  def div(r1, %DSLm.Complex.Polar{mag: r2, angle: a}) do
    new(r1 / r2, a)
  end

  def pow(%DSLm.Complex.Polar{mag: r, angle: a}, b) do
    new(r ** b, a * b)
  end

  def to_polar(c) when is_polar(c), do: c

  def to_polar(c) when is_rect(c) do
    mag = :math.sqrt(c.real ** 2 + c.imag ** 2)
    angle = :math.atan2(c.imag, c.real)

    %DSLm.Complex.Polar{mag: mag, angle: angle}
  end
end

defimpl String.Chars, for: DSLm.Complex.Polar do
  def to_string(%DSLm.Complex.Polar{mag: mag, angle: angle}) do
    "#{mag} · e^i#{angle}"
  end
end
