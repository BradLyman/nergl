defmodule Genotype.NeuronTest do
  use ExUnit.Case, async: true
  doctest Genotype.Neuron

  alias Genotype.Neuron, as: Neuron

  setup do
    [neuron: Neuron.new "cortex"]
  end

  test "basic neuron", context = %{neuron: neuron} do
    assert Genotype.Id.is_id? neuron.id
  end

  test "neuron with inputs", context = %{neuron: basic} do
    neuron =
      basic
      |> Neuron.with_input("sensor", [0.5, 0.25])
      |> Neuron.with_input("other_sensor", [-0.1234])

    assert neuron.id == basic.id
    assert length(Map.keys neuron.input) == 2
    assert length(neuron.input["sensor"]) == 2
    assert length(neuron.input["other_sensor"]) == 1
  end

  test "neuron with outputs", context = %{neuron: basic} do
    neuron = Neuron.with_output basic, "actuator"

    assert neuron.id == basic.id
    assert neuron.output == ["actuator"]
  end
end
