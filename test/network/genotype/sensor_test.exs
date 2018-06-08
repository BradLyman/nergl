defmodule Genotype.SensorTest do
  use ExUnit.Case, async: true
  doctest Genotype.Sensor

  test "create new sensor" do
    cortex = "some_cortex_id"
    sensor = Genotype.Sensor.new(cortex, :myfunc)

    assert Genotype.is_id?(sensor.id)
    assert sensor.cortex == cortex
    assert sensor.behavior == :myfunc
    assert sensor.neurons == []
  end

  test "add neurons to sensor" do
    alias Genotype.Sensor, as: Sense
    initial = Sense.new "cortex"
    full =
      initial
      |> Sense.with_neuron("neuron")
      |> Sense.with_neuron("neuron2")
    assert full != initial
    assert full.id == initial.id
    assert full.neurons == ["neuron2", "neuron"]
  end
end
