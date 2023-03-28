defmodule DSLm.Complex.Polar do
  defstruct mag: 0, angle: 0

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

  def to_polar(c) when is_polar(c), do: c

  def to_polar(c) when is_number(c) do
    %DSLm.Complex.Polar{mag: c, angle: 0}
  end

  def to_polar(c) when is_rect(c) do
    mag = :math.sqrt(c.real ** 2 + c.imag ** 2)
    angle = :math.atan2(c.imag, c.real)

    %DSLm.Complex.Polar{mag: mag, angle: angle}
  end
end

defimpl Multiplicative, for: DSLm.Complex.Polar do
  def mul(%DSLm.Complex.Polar{mag: r1, angle: a1}, %DSLm.Complex.Polar{mag: r2, angle: a2}) do
    %DSLm.Complex.Polar{mag: r1 * r2, angle: a1 + a2}
    |> DSLm.Complex.rect()
  end
end

defimpl Multiplicative, for: Integer do
  def mul(a, b) when is_integer(a) and is_integer(b) do
    a * b
  end

  def mul(a, b) do
    Multiplicative.mul(DSLm.Complex.polar(a), DSLm.Complex.polar(b))
  end
end

defimpl Multiplicative, for: Float do
  def mul(a, b) when is_float(a) and is_float(b) do
    a * b
  end

  def mul(a, b) do
    Multiplicative.mul(DSLm.Complex.polar(a), DSLm.Complex.polar(b))
  end
end

defimpl MulGroup, for: DSLm.Complex.Polar do
  def divide(%DSLm.Complex.Polar{mag: r1, angle: a1}, %DSLm.Complex.Polar{mag: r2, angle: a2}) do
    %DSLm.Complex.Polar{mag: r1 / r2, angle: a1 - a2}
    |> DSLm.Complex.rect()
  end
end

defimpl MulGroup, for: Integer do
  def divide(a, b) when is_integer(a) and is_integer(b) do
    a / b
  end

  def divide(a, b) do
    MulGroup.divide(DSLm.Complex.polar(a), DSLm.Complex.polar(b))
  end
end

defimpl MulGroup, for: Float do
  def divide(a, b) when is_float(a) and is_float(b) do
    a / b
  end

  def divide(a, b) do
    MulGroup.divide(DSLm.Complex.polar(a), DSLm.Complex.polar(b))
  end
end


defimpl String.Chars, for: DSLm.Complex.Polar do
  def to_string(%DSLm.Complex.Polar{mag: mag, angle: angle}) do
    "#{mag} · e^i#{angle}"
  end
end
