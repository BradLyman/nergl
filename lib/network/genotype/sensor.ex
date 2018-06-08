defmodule Genotype.Sensor do
  @moduledoc """
  A sensor sends signals to it's connected neurons in response to the
  environment.
  """

  import Genotype

  @enforce [:id, :cortex, :behavior, :neurons]
  defstruct [:id, :cortex, :behavior, :neurons]

  @doc """
  Create a cortex which isn't configured to wait for any neurons.
  """
  def new(cortex, behavior \\ :rng)
      when is_binary(cortex) and is_atom(behavior) do
    %Genotype.Sensor{
      id: unique_id(:name),
      cortex: cortex,
      behavior: behavior,
      neurons: []
    }
  end

  def with_neuron(
      %Genotype.Sensor{neurons: neurons} = sensor,
      neuron
    )
    when is_binary(neuron)
  do
    %Genotype.Sensor{
      sensor | neurons: [neuron] ++ neurons
    }
  end
end
