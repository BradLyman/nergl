defmodule Genotype do
  @moduledoc """
  This module provides methods for constructing a Genotype for a neural network.
  The Genotype is a datastructure which provides all of the information needed
  to construct the network.
  """

  alias Genotype.Id, as: Id
  alias Genotype.Cortex, as: Cortex
  alias Genotype.Neuron, as: Neuron
  alias Genotype.Actuator, as: Actuator
  alias Genotype.Sensor, as: Sensor

  @doc """
  Build a genotype for a standard feed-forward neural network.

  ## Example

    iex>gen = Genotype.for_network 1, 1, [2]
    iex>length(gen)
    6

  """
  def for_network(num_sensors, num_actuators, layer_sizes \\ [])
    when is_number(num_sensors)
     and is_number(num_actuators)
     and is_list(layer_sizes)
  do
    cortex = Cortex.new
    sensors = build_sensors cortex.id, num_sensors
    neurons = build_neurons cortex.id, layer_sizes, num_actuators
    actuators = build_actuators cortex.id, num_actuators

    layers =
      [sensors] ++ neurons ++ [actuators]
      |> Pairlist.map(&link/2)

    List.flatten [cortex, layers]
  end

  defp link(front, back) when is_list(front) and is_list(back) do
    for neuron <- back do
      link_single front, neuron
    end
  end

  @doc """
  Link every item in the layer to the neuron.
  Assumes that the layer's outputs are all 1-dimensional
  """
  defp link_single(layer, %Neuron{} = neuron)
    when is_list(layer)
  do
    Enum.reduce(layer, neuron, fn source, target ->
      weights =
        case source do
          %Sensor{} -> [rand_weight, rand_weight]
          %Neuron{} -> [rand_weight]
        end
      Neuron.with_input(target, source.id, weights)
    end)
  end

  defp link_single(layer, %Actuator{} = actuator)
    when is_list(layer)
  do
    Enum.reduce(layer, actuator, fn source, target ->
      Actuator.with_neuron(target, source.id)
    end)
  end

  defp build_sensors(cortex_id, num_sensors) do
    for size <- 1..num_sensors, do: Sensor.new(cortex_id)
  end

  defp build_neurons(cortex_id, layer_sizes, num_actuators) do
    neurons = for size <- layer_sizes, do: build_layer(cortex_id, size)
    neurons ++ [build_layer(cortex_id, num_actuators)]
  end

  defp build_actuators(cortex_id, num_actuators) do
    for size <- 1..num_actuators, do: Actuator.new(cortex_id)
  end

  defp build_layer(cortex_id, size) do
    for i <- 1..size, do: Neuron.new(cortex_id)
  end

  defp rand_weight do
    2 * (:rand.uniform - :rand.uniform)
  end
end
