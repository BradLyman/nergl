defmodule NeuronTest do
  use ExUnit.Case
  doctest Neuron

  test "spawn default" do
    {:ok, pid} = Neuron.spawn_link()

    signal = Neuron.sense pid, [1.0, 0.5]

    assert signal >= 0.0 && signal <= 1.0
  end
end
