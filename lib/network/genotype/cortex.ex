defmodule Genotype.Cortex do
  @moduledoc """
  The Cortex is responsible for synchronizing a network's input and output.
  """

  import Genotype

  @enforce [:id, :actuators, :sensors, :neurons]
  defstruct [:id, :actuators, :sensors, :neurons]

  def new do
    %Genotype.Cortex{
      id: Genotype.unique_id(__MODULE__),
      actuators: [],
      sensors: [],
      neurons: []
    }
  end

  def with_sensor(%Genotype.Cortex{} = cortex, sensor)
    when is_binary(sensor)
  do
    Map.update! cortex, :sensors, &(&1 ++ [sensor])
  end

  def with_neuron(%Genotype.Cortex{} = cortex, neuron)
    when is_binary(neuron)
  do
    Map.update! cortex, :neurons, &(&1 ++ [neuron])
  end

  def with_actuator(%Genotype.Cortex{} = cortex, actuator)
    when is_binary(actuator)
  do
    Map.update! cortex, :actuators, &(&1 ++ [actuator])
  end
end
