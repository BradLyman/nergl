defmodule Genotype.CortexTest do
  use ExUnit.Case
  doctest Genotype.Cortex

  alias Genotype.Cortex, as: Cortex

  setup do
    [cortex: Cortex.new]
  end

  test "cortex has valid id", %{cortex: cortex} do
    assert Genotype.is_id? cortex.id
  end

  test "add sensors", %{cortex: empty} do
    sensors = ["sensor", "other_sensor"]
    cortex = Enum.reduce sensors, empty, &(Cortex.with_sensor &2, &1)
    assert cortex.id == empty.id
    assert cortex.sensors == sensors
  end

  test "add neurons", %{cortex: empty} do
    cortex =
      empty
      |> Cortex.with_neuron("neuron")
      |> Cortex.with_neuron("other_neuron")
    assert cortex.id == empty.id
    assert cortex.neurons == ["neuron", "other_neuron"]
  end

  test "add actuators", %{cortex: empty} do
    cortex =
      empty
      |> Cortex.with_actuator("actuator")
      |> Cortex.with_actuator("other")
    assert cortex.id == empty.id
    assert cortex.actuators == ["actuator", "other"]
  end
end
