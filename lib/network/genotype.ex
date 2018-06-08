defmodule Genotype do
  @moduledoc """
  This module provides methods for constructing a Genotype for a neural network.
  The Genotype is a datastructure which provides all of the information needed
  to construct the network.

  ## Examples

    iex> id = Genotype.unique_id "some_prefix"
    iex> Genotype.is_id? id
    true

    iex> Genotype.is_id? "this isn't an id"
    false

  """

  @id_pattern ~r/(\w+)-(-?)(\d+)/

  @doc """
  Generate a new unique id using 'name' as a prefix.
  """
  def unique_id(name) do
    "#{name}-#{Integer.to_string(System.unique_integer())}"
  end

  @doc """
  Check if the provided id matches the format used by this module.
  """
  def is_id?(id) do
    Regex.match?(@id_pattern, id)
  end
end

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
