defmodule GenotypeTest do
  use ExUnit.Case, async: true
  doctest Genotype

  test "unique id has prefix" do
    [prefix, _, _] =
      "prefix"
      |> Genotype.unique_id()
      |> String.split("-")

    assert prefix == "prefix"
  end

  test "unique id has integer suffix" do
    [_, _, id] =
      "prefix"
      |> Genotype.unique_id()
      |> String.split("-")

    assert Integer.parse(id) != :error
  end
end

