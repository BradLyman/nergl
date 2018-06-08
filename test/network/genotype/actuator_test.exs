defmodule Genotype.ActuatorTest do
  use ExUnit.Case, async: true
  doctest Genotype.Actuator

  test "create new actuator" do
    cortex = "some_cortex_id"
    actuator = Genotype.Actuator.new(cortex, :myfunc)

    assert Genotype.is_id?(actuator.id)
    assert actuator.cortex == cortex
    assert actuator.behavior == :myfunc
    assert actuator.neurons == []
  end

  test "add neurons to actuator" do
    alias Genotype.Actuator, as: Act
    initial = Act.new "cortex"
    full =
      initial
      |> Act.with_neuron("neuron")
      |> Act.with_neuron("neuron2")
    assert full != initial
    assert full.id == initial.id
    assert full.neurons == ["neuron2", "neuron"]
  end
end
