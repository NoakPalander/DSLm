defmodule DSLm.Complex.Rect do
  defstruct real: 0, imag: 0

  def new(real, imag), do: %DSLm.Complex.Rect{real: real, imag: imag}

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

  def add(%DSLm.Complex.Rect{real: r1, imag: i1}, %DSLm.Complex.Rect{real: r2, imag: i2}) do
    new(r1 + r2, i1 + i2)
  end

  def add(%DSLm.Complex.Rect{real: r1, imag: i}, r) do
    new(r1 + r, i)
  end

  def add(r, %DSLm.Complex.Rect{real: r1, imag: i}) do
    new(r1 + r, i)
  end

  def sub(%DSLm.Complex.Rect{real: r1, imag: i1}, %DSLm.Complex.Rect{real: r2, imag: i2}) do
    new(r1 - r2, i1 - i2)
  end

  def sub(%DSLm.Complex.Rect{real: r1, imag: i}, r) do
    new(r1 - r, i)
  end

  def sub(r, %DSLm.Complex.Rect{real: r1, imag: i}) do
    new(r1 - r, i)
  end

  def to_rect(c) when is_rect(c), do: c

  def to_rect(c) when is_polar(c) do
    new(c.mag * :math.cos(c.angle), c.mag * :math.sin(c.angle))
  end
end

defimpl String.Chars, for: DSLm.Complex.Rect do
  def to_string(%DSLm.Complex.Rect{real: real, imag: imag}) do
    "#{real} + i#{imag}"
  end
end
