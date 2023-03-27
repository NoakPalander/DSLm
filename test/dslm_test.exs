defmodule DslmTest do
  use ExUnit.Case
  doctest Dslm

  test "greets the world" do
    assert Dslm.hello() == :world
  end
end
