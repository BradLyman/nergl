defmodule Genotype.Cortex do
  @moduledoc """
  The Cortex is responsible for synchronizing a network's input and output.

  ## Examples

    iex> cortex = Genotype.Cortex.new
    iex> cortex = Genotype.Cortex.with_sensor cortex, "sensor"
    iex> cortex = Genotype.Cortex.with_actuator cortex, "actuator"
    iex> cortex = Genotype.Cortex.with_neuron cortex, "neuron"
    iex> cortex.sensors
    ["sensor"]
    iex> cortex.actuators
    ["actuator"]
    iex> cortex.neurons
    ["neuron"]

  """

  alias Genotype.Id, as: Id

  @enforce [:id, :actuators, :sensors, :neurons]
  defstruct [:id, :actuators, :sensors, :neurons]

  @doc """
  Create a new Cortex with no actuators, sensors, or neurons.
  """
  def new do
    %Genotype.Cortex{
      id: Id.unique("cortex"),
      actuators: [],
      sensors: [],
      neurons: []
    }
  end

  @doc """
  Add a sensor to the cortex.
  """
  def with_sensor(%Genotype.Cortex{} = cortex, sensor)
    when is_binary(sensor)
  do
    Map.update! cortex, :sensors, &(&1 ++ [sensor])
  end

  @doc """
  Add a neuron to the cortex.
  """
  def with_neuron(%Genotype.Cortex{} = cortex, neuron)
    when is_binary(neuron)
  do
    Map.update! cortex, :neurons, &(&1 ++ [neuron])
  end

  @doc """
  Add an actuator to the cortex.
  """
  def with_actuator(%Genotype.Cortex{} = cortex, actuator)
    when is_binary(actuator)
  do
    Map.update! cortex, :actuators, &(&1 ++ [actuator])
  end
end
