defmodule LinalgTest do
  use ExUnit.Case
  doctest Linalg

  test "dot product yields the correct results" do
    product = Linalg.dot [0.5, 0.5], [1.0, 1.0]
    assert  product == 1.0
  end
end
