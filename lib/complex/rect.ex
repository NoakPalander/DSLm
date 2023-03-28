defmodule DSLm.Complex.Rect do
  defstruct real: 0, imag: 0

  defmacro is_rect(c) do
    quote do
      is_struct(unquote(c), unquote(__MODULE__))
    end
  end

  defmacro is_polar(c) do
    quote do
      is_struct(unquote(c), DSLm.Complex.Polar)
    end
  end

  def to_rect(c) when is_rect(c), do: c

  def to_rect(c) when is_number(c) do
    %DSLm.Complex.Rect{real: c, imag: 0}
  end

  def to_rect(c) when is_polar(c) do
    %DSLm.Complex.Rect{real: c.mag * :math.cos(c.angle), imag: c.mag * :math.sin(c.angle)}
  end
end

defimpl Additive, for: DSLm.Complex.Rect do
  def add(%DSLm.Complex.Rect{real: r1, imag: i1}, %DSLm.Complex.Rect{real: r2, imag: i2}) do
    %DSLm.Complex.Rect{real: r1 + r2, imag: i1 + i2}
  end
end

defimpl Additive, for: Integer do
  def add(a, b) when is_integer(a) and is_integer(b) do
    a + b
  end

  def add(a, b) do
    Additive.add(DSLm.Complex.rect(a), DSLm.Complex.rect(b))
  end
end

defimpl Additive, for: Float do
  def add(a, b) when is_float(a) and is_float(b) do
    a + b
  end

  def add(a, b) do
    Additive.add(DSLm.Complex.rect(a), DSLm.Complex.rect(b))
  end
end

defimpl AddGroup, for: DSLm.Complex.Rect do
  def sub(%DSLm.Complex.Rect{real: r1, imag: i1}, %DSLm.Complex.Rect{real: r2, imag: i2}) do
    %DSLm.Complex.Rect{real: r1 - r2, imag: i1 - i2}
  end
end

defimpl AddGroup, for: Integer do
  def sub(a, b) when is_integer(a) and is_integer(b) do
    a - b
  end

  def sub(a, b) do
    AddGroup.sub(DSLm.Complex.rect(a), DSLm.Complex.rect(b))
  end
end

defimpl AddGroup, for: Float do
  def sub(a, b) when is_float(a) and is_float(b) do
    a - b
  end

  def sub(a, b) do
    AddGroup.sub(DSLm.Complex.rect(a), DSLm.Complex.rect(b))
  end
end

defimpl Multiplicative, for: DSLm.Complex.Rect do
  def mul(a, b) do
    Multiplicative.mul(DSLm.Complex.polar(a), DSLm.Complex.polar(b))
  end
end

defimpl MulGroup, for: DSLm.Complex.Rect do
  def divide(a, b) do
    MulGroup.divide(DSLm.Complex.polar(a), DSLm.Complex.polar(b))
  end
end

defimpl String.Chars, for: DSLm.Complex.Rect do
  def to_string(%DSLm.Complex.Rect{real: real, imag: imag}) do
    "#{real} + i#{imag}"
  end
end
