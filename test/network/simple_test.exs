defmodule Network.SimpleTest do
  use ExUnit.Case

  alias Network.Simple.Actuator, as: Act
  alias Network.Simple.Neuron, as: Neuron
  alias Network.Simple.Sensor, as: Sensor
  alias Network.Simple.Cortex, as: Cortex

  doctest Act
  doctest Neuron

  test "single actuator" do
    {:ok, actuator} = Act.start_link()
    assert Act.sense(actuator, 0.5) == 0.5
  end

  test "neuron with actuator" do
    {:ok, act} = Act.start_link()
    {:ok, neuron} = Neuron.start_link(act)

    signal = Neuron.sense(neuron, [1.0, 1.0])

    assert 0.0 <= signal and signal <= 1.0
  end

  test "sensor with neuron and actuator" do
    {:ok, act} = Act.start_link()
    {:ok, neuron} = Neuron.start_link(act)
    {:ok, sensor} = Sensor.start_link(neuron)

    signal = Sensor.sync(sensor)

    assert 0.0 <= signal and signal <= 1.0
  end

  test "cortex" do
    {:ok, cortex} = Cortex.start_link()
    result = Cortex.sense_think_act(cortex)
    assert 0.0 <= result and result <= 1.0
  end
end
