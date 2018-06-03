defmodule NerglTest do
  use ExUnit.Case
  doctest Nergl

  test "greets the world" do
    assert Nergl.hello() == :world
  end
end
