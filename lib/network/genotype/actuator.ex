defmodule Genotype.Actuator do
  @moduledoc """
  An actuator manipulates the environment based on the inputs it recieves
  from it's connected neurons.
  """

  import Genotype

  @enforce [:id, :cortex, :behavior, :neurons]
  defstruct [:id, :cortex, :behavior, :neurons]

  @doc """
  Create a cortex which isn't configured to wait for any neurons.
  """
  def new(cortex, behavior \\ :print)
      when is_binary(cortex) and is_atom(behavior) do
    %Genotype.Actuator{
      id: unique_id(:name),
      cortex: cortex,
      behavior: behavior,
      neurons: []
    }
  end

  def with_neuron(
      %Genotype.Actuator{
        id: id,
        cortex: cortex,
        behavior: behavior,
        neurons: neurons
      },
      neuron
    )
    when is_binary(neuron)
  do
    %Genotype.Actuator{
      id: id,
      cortex: cortex,
      behavior: behavior,
      neurons: [neuron] ++ neurons
    }
  end
end
