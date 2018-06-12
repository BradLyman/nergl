defmodule Genotype.Actuator do
  @moduledoc """
  An actuator manipulates the environment based on the inputs it recieves
  from it's connected neurons.
  """

  alias Genotype.Id, as: Id

  @enforce [:id, :cortex, :behavior, :neurons]
  defstruct [:id, :cortex, :behavior, :neurons]

  @doc """
  Create a cortex which isn't configured to wait for any neurons.
  """
  def new(cortex, behavior \\ :print)
      when is_binary(cortex) and is_atom(behavior) do
    %Genotype.Actuator{
      id: Id.unique("actuator"),
      cortex: cortex,
      behavior: behavior,
      neurons: []
    }
  end

  def with_neuron(
      %Genotype.Actuator{neurons: neurons} = actuator,
      neuron
    )
    when is_binary(neuron)
  do
    %Genotype.Actuator{
      actuator | neurons: [neuron] ++ neurons
    }
  end
end
