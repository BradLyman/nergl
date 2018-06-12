defmodule Genotype.IdTest do
  use ExUnit.Case, async: true
  doctest Genotype.Id

  test "unique id has prefix" do
    [prefix, _, _] =
      "prefix"
      |> Genotype.Id.unique()
      |> String.split("-")

    assert prefix == "prefix"
  end

  test "unique id has integer suffix" do
    [_, _, id] =
      "prefix"
      |> Genotype.Id.unique()
      |> String.split("-")

    assert Integer.parse(id) != :error
  end
end
